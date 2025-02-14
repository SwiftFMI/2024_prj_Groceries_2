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
    let categoryName:String
    var image: String
    var brandName: String
    var startDate: Date = Date()
    var endDate: Date = Date()
    var offerPrice: Double?
    
    
    //Only for testing
    init(id: String = UUID().uuidString,
             name: String,
             price: Double,
             image: String = "",
         categoryName:String = "",
             brandName: String = "",
             startDate: Date = Date(),
             endDate: Date = Date(),
             offerPrice: Double? = nil) {
                self.id = id
                self.name = name
                self.price = price
                self.image = image
                self.categoryName = categoryName
                self.brandName = brandName
                self.startDate = startDate
                self.endDate = endDate
                self.offerPrice = offerPrice
            }
}
