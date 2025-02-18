//
//  ProductViewModel.swift
//  Groceries
//
//  Created by Lazar Avramov on 18.02.25.
//

import Foundation
import Firebase
import FirebaseFirestore

class ProductViewModel :ObservableObject {
    @Published var product: Product?
    @Published var products: [Product] = []
    
    func createProduct(name: String, price: Double, image: String, shopName: String) async throws  {
        do {
            let product = Product(name: name, price: price, image: image, shopName : shopName )
            let encodedProduct = try Firestore.Encoder().encode(product)
            try await Firestore.firestore().collection("products").addDocument(data: encodedProduct)
            
        } catch {
            print("Debug:failed to create user with error\(error.localizedDescription)")
        }
    }
    
    func fetchProducts() async {
        do {
            let snapshot = try await Firestore.firestore().collection("products").getDocuments()
            let fetchedProducts = snapshot.documents.compactMap { document in
                try? document.data(as: Product.self)
            }

            DispatchQueue.main.async {
                self.products = fetchedProducts
            }
        } catch {
            print("Error fetching products: \(error.localizedDescription)")
        }
    }
}
