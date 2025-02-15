//
//  ProductList.swift
//  Groceries
//
//  Created by Yani Yankov on 2/15/25.
//

import Foundation

struct ProductList: Codable, Identifiable {
    let id: UUID
    let name: String
    let products: [Product]?
}
