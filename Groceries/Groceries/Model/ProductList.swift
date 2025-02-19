//
//  ProductList.swift
//  Groceries
//
//  Created by Yani Yankov on 2/15/25.
//

import Foundation

struct ProductList: Codable, Identifiable, Hashable {
    let id: String
    var name: String
    var productIDs: [String : Int]?
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
        self.productIDs = nil
    }
}
