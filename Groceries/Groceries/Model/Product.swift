//
//  Product.swift
//  Groceries
//
//  Created by Lazar Avramov on 13.02.25.
//

import Foundation

struct Product: Identifiable,Codable {
    
    let id:String
    let name: String
    let price: Double
    let image: String
    let shopName: String
    
    //Only for testing
    init(id: String = UUID().uuidString,
             name: String,
             price: Double,
             image: String = "",
             shopName: String = "") {
                self.id = id
                self.name = name
                self.price = price
                self.image = image
                self.shopName = shopName
            }
}
