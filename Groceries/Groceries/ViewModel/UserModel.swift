//
//  UserController.swift
//  Groceries
//
//  Created by Lazar Avramov on 10.02.25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

protocol Authenticatable {
    var formIsValid:Bool { get }
}

@MainActor
class UserModel: ObservableObject {
    
//    private let db = Firestore.firestore()
    
    @Published var user: User?
    @Published var userItems: UserItems = UserItems()
    @Published var userSession: FirebaseAuth.User?
    @Published var isLoading: Bool = true
    @Published var navigationPath = NavigationPath() 
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
            self.isLoading = false
        }
    }
    
    func signIn(withEmail email:String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            self.isLoading = false
        } catch {
            self.isLoading = false
        }
    }
    
    func signUp(withEmail email:String, password: String, name: String, surname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user =  User(id: result.user.uid, name: name, surname: surname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("Debug:failed to create user with error\(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.user = nil
        } catch {
            print("Debug:failed to sign out with error\(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
//        guard let user = Auth.auth().currentUser else { return }
              //TODO
    }
    
    func fetchUser() async  {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshotData = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {
            return
        }
        if let rawData = snapshotData.data() {
            print(rawData)
        } else {
        }
        guard let user = try? snapshotData.data(as: User.self) else {
            return
        }
        
        self.user = user
        
        Task {
            await fetchData()
        }
    }
    
    func addList(name: String) {
        self.user?.productLists?.append(ProductList(name: name))
        Task {
            await self.updateUserListsToDB()
        }
    }
    
    func fetchData() async {
        self.userItems = .init()
        
        guard let productLists = user?.productLists else { return }
        self.userItems.lists = Set(productLists)
        
        let lists = userItems.lists
        
        for list in lists {
            let products = await self.fetchProducts(list: list)
            products.forEach { product in
                self.userItems.products.insert(product)
            }
            print("CASHED")
        }
        
        let products = userItems.products
        for product in products {
            let discounts = await self.fetchDiscounts(product: product)
            discounts.forEach { discount in
                self.userItems.discounts.insert(discount)
            }
        }
    }
    
    func fetchProducts(list: ProductList) async -> [Product] {
        let db = Firestore.firestore()
        var products: [Product] = []
        guard let productIDs = list.productIDs else { return products }
        
        for (productID, _) in productIDs {
            do {
                let document = try await db.collection("products").document(productID).getDocument()
                
                if let rawData = document.data() {
                    print("Raw data: \(rawData)")
                } else {
                    print("No document data found.")
                }

                
                if let product = try document.data(as: Product?.self) {
                    products.append(product)
                }
            } catch {
                print("Error fetching product with ID \(productID): \(error)")
            }
        }
        return products
    }
    
    func fetchDiscounts(product: Product) async -> [Discount] {
        let db = Firestore.firestore()
        var discounts: [Discount] = []
        guard let discountIDs = product.discountIDs else { return discounts }
        
        for discountID in discountIDs {
            if let discount = self.userItems.discounts.first(where: { $0.id == discountID }) {
                discounts.append(discount)
            } else {
                do {
                    let document = try await db.collection("discounts").document(discountID).getDocument().data()
                   
                    if
                        let id = document?["id"] as? String,
                        let startTimestamp = document?["startDate"] as? Timestamp,
                        let endTimestamp = document?["endDate"] as? Timestamp,
                        let percent = document!["percent"] as? Double {
                        let startDate = Date(timeIntervalSince1970: TimeInterval(startTimestamp.seconds))
                        let endDate = Date(timeIntervalSince1970: TimeInterval(endTimestamp.seconds))
                        discounts.append(Discount(id: id, startDate: startDate, endDate: endDate, percent: percent))
                    }
                } catch {
                    print("Error fetching discount with ID \(discountID): \(error)")
                }
            }
        }
        return discounts
    }
    
    func addItemToDB(item: GroceriesModelProtocol) async {
        let db = Firestore.firestore()
        do {
            try await db.collection(item.collectionName).document(item.id).setData(item.toDictionary())
            print("Document successfully written!")
        } catch {
            print("Error writing document: \(error)")
        }
    }
    
    func updateUserListsToDB() async {
        let db = Firestore.firestore()
        do {
            guard let user = self.user else { return }
            let userRef = db.collection("users").document(user.id)
            let productLists = user.productLists ?? []
            let toUpload = productLists.map{ list in
                list.toDictionary()
            }

            try await userRef.updateData([
                "productLists" : toUpload
            ])
            print("Lists successfully updated!")
        } catch {
            print("Error writing document: \(error)")
        }
    }
    
    func updateSingleListsToDB(list: ProductList) async {
        let db = Firestore.firestore()
        do {
            guard let user = self.user else { return }
            let listRef = db.collection("users").document(user.id).collection(list.collectionName).document(list.id)
            let productIDs = list.productIDs ?? ["test" : 5]

            try await listRef.updateData([
                "productIDs" : productIDs
            ])
            print("Lists successfully updated!")
        } catch {
            print("Error writing document: \(error)")
        }
    }
    
    func addProductToList(list: ProductList, product: Product, amount: Int) {
        
        guard let user = self.user else { return }
        
        guard let listIndex = user.productLists?.firstIndex(where: { $0.id == list.id }) else { return }
        
        var rawList = user.productLists?[listIndex]
        
        if let curr = rawList?.productIDs?[product.id] {
            self.user?.productLists?[listIndex].productIDs?[product.id]! += amount
            self.user?.productLists?[listIndex].productIDs?[product.id]! += amount
        } else {
            if self.user?.productLists?[listIndex].productIDs != nil {
                self.user?.productLists?[listIndex].productIDs?[product.id] = amount
            } else {
                self.user?.productLists?[listIndex].productIDs = [product.id : amount]
            }
        }
        
        self.userItems.products.insert(product)
        
    }
    
    func searchProducts(byName name: String) async -> [Product] {
        let db = Firestore.firestore()
        var searchResults: [Product] = []
        let toLowerName = name.lowercased()
        
        do {
            let products = try await db.collection("products")
                .whereField("toLowerName", isGreaterThanOrEqualTo: toLowerName)
                .whereField("toLowerName", isLessThanOrEqualTo: toLowerName + "\u{f8ff}")
                .getDocuments()
            
            for document in products.documents {
                if let product = try? document.data(as: Product.self) {
                    searchResults.append(product)
                }
            }
        } catch {
            print("Error searching products: \(error.localizedDescription)")
        }
        
        return searchResults
    }
}
