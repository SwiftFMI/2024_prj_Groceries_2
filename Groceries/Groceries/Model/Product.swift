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
    let discountIDs: [String]?
//    var startDate: Date?
//    var endDate: Date?
//    var offerPrice: Double?
    
    
    //Only for testing
    init(id: String = UUID().uuidString,
         name: String,
         price: Double,
         image: String = "",
         categoryName:String = "",
         brandName: String = "",
//         startDate: Date = Date(),
//         endDate: Date = Date(),
//         offerPrice: Double? = nil
         discountIDs: [String]?) {
        self.id = id
        self.name = name
        self.price = price
        self.image = image
        self.categoryName = categoryName
        self.brandName = brandName
        self.discountIDs = discountIDs
        
        //                self.startDate = startDate
        //                self.endDate = endDate
        //                self.offerPrice = offerPrice
    }
    
    enum CodingKeys: String, CodingKey {
            case id, name, price, categoryName, image, brandName, discountIDs
        }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
           self.name = try container.decode(String.self, forKey: .name)
           self.price = try container.decode(Double.self, forKey: .price)
           self.categoryName = try container.decodeIfPresent(String.self, forKey: .categoryName) ?? ""
           self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
           self.brandName = try container.decodeIfPresent(String.self, forKey: .brandName) ?? ""
           self.discountIDs = try container.decodeIfPresent([String].self, forKey: .discountIDs)
       }
}
