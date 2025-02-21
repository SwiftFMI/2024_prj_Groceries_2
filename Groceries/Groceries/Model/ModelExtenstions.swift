//
//  ModelExtenstions.swift
//  Groceries
//
//  Created by Yani Yankov on 2/18/25.
//

import Foundation

protocol GroceriesModelProtocol {
    var collectionName: String { get }
    var id: String { get }
    func toDictionary() -> [String : Any]
}

extension Discount: GroceriesModelProtocol {
    var collectionName: String {
        "discounts"
    }
    
    func toDictionary() -> [String : Any] {
        [
            "id" : self.id,
            "startDate" : self.startDate,
            "endDate" : self.endDate,
            "percent" : self.percent
        ]
    }
}

extension Product: GroceriesModelProtocol {
    var collectionName: String {
        "products"
    }
    
    public func toDictionary() -> [String : Any] {
        [
            "id": self.id,
            "name": self.name,
            "price": self.price,
            "categoryName": self.categoryName,
            "image": self.image,
            "brandName": self.brandName,
            "shopName": self.shopName,
            "discountIDs": self.discountIDs ?? [],
            "toLowerName" : self.toLowerName
        ]
    }
}

extension ProductList: GroceriesModelProtocol {
    var collectionName: String {
        "productLists"
    }
    
    func toDictionary() -> [String : Any] {
        [
            "id" : self.id,
            "name" : self.name,
            "productIDs" : self.productIDs ?? []
        ]
    }
}
