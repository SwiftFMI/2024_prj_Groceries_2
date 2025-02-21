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
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.productIDs = try? container.decodeIfPresent([String : Int].self, forKey: .productIDs)
    }
}
