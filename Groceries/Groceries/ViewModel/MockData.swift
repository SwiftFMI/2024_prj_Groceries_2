//
//  MockData.swift
//  Groceries
//
//  Created by Yani Yankov on 2/16/25.
//

import Foundation

let productMock1 = [
    Product(name: "Product1", price: 33.50, discountIDs: [discountsMock[0].id,discountsMock[3].id] ),
    Product(name: "Product2", price: 33.50, discountIDs: [discountsMock[1].id])
]

let productMock2 = [
    Product(name: "Product3", price: 33.50, discountIDs: [discountsMock[0].id,discountsMock[3].id] ),
    Product(name: "Product4", price: 33.50, discountIDs: [discountsMock[1].id,discountsMock[2].id] ),
    Product(name: "Product5", price: 33.50, discountIDs: nil )
]

let productMock3 = [Product(name: "Product6", price: 33.50, discountIDs: [discountsMock[3].id])]

let discountsMock = [
    Discount(id: UUID.init().uuidString, startDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!, endDate: Calendar.current.date(byAdding: .day, value: 10, to: Date())!, percent: 10),
    Discount(id: UUID.init().uuidString, startDate: Date(), endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!, percent: 30),
    Discount(id: UUID.init().uuidString, startDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!, endDate: Calendar.current.date(byAdding: .day, value: 10, to: Date())!, percent: 50),
    Discount(id: UUID.init().uuidString, startDate: Date(), endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!, percent: 40)
]
