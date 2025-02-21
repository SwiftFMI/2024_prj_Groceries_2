//
//  Product.swift
//  Groceries
//
//  Created by Lazar Avramov on 13.02.25.
//

import Foundation

struct Product: Identifiable, Codable, Hashable {
    
    let id: String
    let name: String
    let price: Double
    let categoryName: String
    let image: String
    let brandName: String
    let shopName: String
    let discountIDs: [String]?
    let toLowerName: String
    
    
    init(id: String = UUID().uuidString,
         name: String,
         price: Double,
         categoryName:String = "",
         image: String = "",
         brandName: String = "",
         shopName: String = "",
         discountIDs: [String]?) {
        self.id = UUID().uuidString
        self.name = name
        self.price = price
        self.image = image
        self.categoryName = categoryName
        self.brandName = brandName
        self.shopName = shopName
        self.discountIDs = discountIDs
        self.toLowerName = name.lowercased()
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, price, categoryName, image, brandName, shopName, discountIDs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        self.categoryName = try container.decodeIfPresent(String.self, forKey: .categoryName) ?? ""
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.brandName = try container.decodeIfPresent(String.self, forKey: .brandName) ?? ""
        self.shopName = try container.decodeIfPresent(String.self, forKey: .shopName) ?? ""
        self.discountIDs = try container.decodeIfPresent([String].self, forKey: .discountIDs)
        self.toLowerName = self.name.lowercased()
    }
}
