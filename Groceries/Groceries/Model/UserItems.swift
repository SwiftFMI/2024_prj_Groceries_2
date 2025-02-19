//
//  UserViewModel.swift
//  Groceries
//
//  Created by Yani Yankov on 2/15/25.
//

import Foundation

struct UserItems {
    var lists: [ProductList] = []
    var products: [Product] = []
    var discounts: [Discount] = []
}

//class UserViewModel: ObservableObject {
//    private let db = Firestore.firestore()
//    
//    @Published var user: User? = nil
//    @Published var userListProducts: UserListProducts = UserListProducts()
//    
//    init(user: User?) {
//        self.user = user
//    }
//    
//    func addList(name: String) {
//        self.user?.productLists?.append(ProductList(name: name))
//        self.user = user
//    }
//    
//    func updateUser(user: User?) {
//        guard let user = user else { return }
//        self.user = user
//        Task {
//            await fetchData()
//        }
//    }
//    
//    func fetchData() async {
//        guard let productLists = user?.productLists else { return }
//        self.userListProducts.lists = productLists
//        
//        let lists = userListProducts.lists
//        
//        for list in lists {
//            let products = await self.fetchProducts(list: list)
//            self.userListProducts.products = Array(Set(products))
//        }
//        
//        let products = userListProducts.products
//        for product in products {
//            let discounts = await self.fetchDiscounts(product: product)
//            self.userListProducts.discounts = Array(Set(discounts))
//        }
//    }
//    
//    func fetchProducts(list: ProductList) async -> [Product] {
//        var products: [Product] = []
//        guard let productIDs = list.productIDs else { return products }
//        
//        for (productID, _) in productIDs {
//            do {
//                let document = try await db.collection("products").document(productID).getDocument()
//                
//                if let rawData = document.data() {
//                    print("Raw data: \(rawData)")  // This prints the raw dictionary of the document
//                } else {
//                    print("No document data found.")
//                }
//
//                
//                if let product = try document.data(as: Product?.self) {
//                    products.append(product)
//                }
//            } catch {
//                print("Error fetching product with ID \(productID): \(error)")
//            }
//        }
//        return products
//    }
//    
//    func fetchDiscounts(product: Product) async -> [Discount] {
//        var discounts: [Discount] = []
//        guard let discountIDs = product.discountIDs else { return discounts }
//        
//        for discountID in discountIDs {
//            do {
//                let document = try await db.collection("discount").document(discountID).getDocument()
//                
//                if let discount = try document.data(as: Discount?.self) {
//                    discounts.append(discount)
//                }
//            } catch {
//                print("Error fetching discount with ID \(discountID): \(error)")
//            }
//        }
//        return discounts
//    }
//    
//    func addItemToDB(item: GroceriesModelProtocol) async {
//        do {
//            try await db.collection(item.collectionName).document(item.id).setData(item.toDictionary())
//            print("Document successfully written!")
//        } catch {
//            print("Error writing document: \(error)")
//        }
//    }
//}
