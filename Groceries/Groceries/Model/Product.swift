//
//  Product.swift
//  Groceries
//
//  Created by Lazar Avramov on 13.02.25.
//

import Foundation

struct Product: Identifiable, Codable {
    
    let id: String
    let name: String
    let price: Double
    let categoryName: String
    let image: String
    let brandName: String
    let discount: Discount?
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
         discount: Discount) {
        self.id = id
        self.name = name
        self.price = price
        self.image = image
        self.categoryName = categoryName
        self.brandName = brandName
        self.discount = discount
        
        //                self.startDate = startDate
        //                self.endDate = endDate
        //                self.offerPrice = offerPrice
    }
}
