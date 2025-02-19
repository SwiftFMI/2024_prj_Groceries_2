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

protocol Authenticatable {
    var formIsValid:Bool { get }
}

@MainActor
class UserModel: ObservableObject {
    
    private let db = Firestore.firestore()
    
    @Published var user: User?
    @Published var userItems: UserItems = UserItems()
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email:String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            
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
            print("No Raw data")
        }
        guard let user = try? snapshotData.data(as: User.self) else {
            print("COULDN't DECODE")
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
        guard let productLists = user?.productLists else { return }
        self.userItems.lists = productLists
        
        let lists = userItems.lists
        
        for list in lists {
            let products = await self.fetchProducts(list: list)
            self.userItems.products = Array(Set(products))
        }
        
        let products = userItems.products
        for product in products {
            let discounts = await self.fetchDiscounts(product: product)
            self.userItems.discounts = Array(Set(discounts))
        }
    }
    
    func fetchProducts(list: ProductList) async -> [Product] {
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
        var discounts: [Discount] = []
        guard let discountIDs = product.discountIDs else { return discounts }
        
        for discountID in discountIDs {
            do {
                let document = try await db.collection("discount").document(discountID).getDocument()
                
                if let discount = try document.data(as: Discount?.self) {
                    discounts.append(discount)
                }
            } catch {
                print("Error fetching discount with ID \(discountID): \(error)")
            }
        }
        return discounts
    }
    
    func addItemToDB(item: GroceriesModelProtocol) async {
        do {
            try await db.collection(item.collectionName).document(item.id).setData(item.toDictionary())
            print("Document successfully written!")
        } catch {
            print("Error writing document: \(error)")
        }
    }
    
    func updateUserListsToDB() async {
        do {
            guard let user = self.user else { return }
            let userRef = Firestore.firestore().collection("users").document(user.id)
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
}
