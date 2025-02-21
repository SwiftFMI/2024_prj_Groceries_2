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
            self.user = user
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
    
    func deleteAccount() async {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        do {
            let userId = currentUser.uid
            try await Firestore.firestore().collection("users").document(userId).delete()
            print("User data successfully deleted from Firestore.")
            
            try await currentUser.delete()
            print("User account successfully deleted.")
            
            self.userSession = nil
            self.user = nil
        } catch {
            print("Error deleting account: \(error.localizedDescription)")
        }
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
        if self.user?.productLists != nil {
            self.user?.productLists?.append(ProductList(name: name))
        } else {
            self.user?.productLists = [ProductList(name: name)]
        }
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
    
    func fetchProductsByName(name: String) async -> [Product] {
        let db = Firestore.firestore()
        var products: [Product] = []

        let lowercasedName = name.lowercased()

        do {
            let snapshot = try await db.collection("products")
                .whereField("toLowerName", isGreaterThanOrEqualTo: lowercasedName)
                .whereField("toLowerName", isLessThanOrEqualTo: lowercasedName + "\u{f8ff}")
                .getDocuments()
            
            for document in snapshot.documents {
                if let product = try? document.data(as: Product.self) {
                    products.append(product)
                }
            }
        } catch {
            print("Error fetching products with name \(name): \(error)")
        }
        
        return products
    }
    
    func findBestShopForList(list: ProductList) async -> (String, Double) {
        var bestShop = ("", 0.0)
        var shops: [String : Double] = [:]
        
        guard let productIDs = list.productIDs else { return bestShop }
        
        for (productID, amount) in productIDs {
            if let product = self.userItems.products.first(where: { $0.id == productID }) {
                let matchingProducts = await self.fetchProductsByName(name: product.name)
                
                for matchedProduct in matchingProducts {
                    let discounts = await self.fetchDiscounts(product: matchedProduct)
                    var productPrice = matchedProduct.price
                    
                    for discount in discounts {
                        let currDate = Date()
                        if discount.startDate < currDate && discount.endDate > currDate {
                            productPrice = productPrice - productPrice * discount.percent / 100
                        }
                    }
                    let totalPrice = productPrice * Double(amount)
                    
                    if let currShopPrice = shops[matchedProduct.shopName] {
                        shops[matchedProduct.shopName] = currShopPrice + totalPrice
                    } else {
                        shops[matchedProduct.shopName] = totalPrice
                    }
                }
            }
        }
        
        if let best = shops.min(by: { a, b in a.value < b.value }) {
            bestShop.0 = best.key
            bestShop.1 = best.value
        }
        return bestShop
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
    
    func addProductToList(list: ProductList, product: Product, amount: Int) {
        
        guard let user = self.user else { return }
        
        guard let listIndex = user.productLists?.firstIndex(where: { $0.id == list.id }) else { return }
        
        var rawList = user.productLists?[listIndex]
        
        if let curr = rawList?.productIDs?[product.id] {
            self.user?.productLists?[listIndex].productIDs?[product.id]! += amount
        } else {
            if self.user?.productLists?[listIndex].productIDs != nil {
                self.user?.productLists?[listIndex].productIDs?[product.id] = amount
            } else {
                self.user?.productLists?[listIndex].productIDs = [product.id : amount]
            }
        }
        
        self.userItems.products.insert(product)
        guard let listToUpdate = self.user?.productLists?.first(where: { $0.id == list.id }) else { return }
        Task {
            await self.updateUserListsToDB()
        }
        
    }
    
    func removeProductFromList(list: ProductList, product: Product) {
        
        guard let user = self.user else { return }
        
        guard let listIndex = user.productLists?.firstIndex(where: { $0.id == list.id }) else { return }
        
        let rawList = user.productLists?[listIndex]
        
        if rawList?.productIDs?[product.id] != nil {
            self.user?.productLists?[listIndex].productIDs?[product.id]! -= 1
            if self.user?.productLists?[listIndex].productIDs?[product.id]! == 0 {
                self.userItems.products.remove(product)
                self.user?.productLists?[listIndex].productIDs?.removeValue(forKey: product.id)
            }
            
            Task {
                await self.updateUserListsToDB()
            }
        }
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
    
    func calculateDiscountforProduct(product: Product) async -> Double {
        var price = product.price
        
            var discounts:[Discount] = []
            
            let currDate = Date()
            
            discounts = await self.fetchDiscounts(product: product)
            
            for discount in discounts {
                if discount.startDate < currDate, discount.endDate > currDate {
                    print("minus")
                    price -= product.price * discount.percent / 100
                }
            }
        print("\(price)")
        return price
    }
    
    func calculateListTotalPrice(list: ProductList) async -> Double {
        var totalPrice = 0.0
        guard let productIDs = list.productIDs else { return totalPrice }
        for (productID, amount) in productIDs {
            if let product = self.userItems.products.first(where: { $0.id == productID }) {
                let discountPrice = await self.calculateDiscountforProduct(product: product)
                totalPrice += discountPrice * Double(amount)
            }
        }

        return totalPrice
    }
}
