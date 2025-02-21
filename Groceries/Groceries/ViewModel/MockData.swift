////
////  MockData.swift
////  Groceries
////
////  Created by Yani Yankov on 2/16/25.
////
//
//import Foundation
//
//let productMock1 = [
//    Product(name: "Product1", price: 33.50, discountIDs: [discountsMock[0].id,discountsMock[3].id] ),
//    Product(name: "Product2", price: 33.50, discountIDs: [discountsMock[1].id])
//]
//
//let productMock2 = [
//    Product(name: "Product3", price: 33.50, discountIDs: [discountsMock[0].id,discountsMock[3].id] ),
//    Product(name: "Product4", price: 33.50, discountIDs: [discountsMock[1].id,discountsMock[2].id] ),
//    Product(name: "Product5", price: 33.50, discountIDs: nil )
//]
//
//let productMock3 = [Product(name: "Product6", price: 33.50, discountIDs: [discountsMock[3].id])]
//
//let discountsMock = [
//    Discount(id: UUID.init().uuidString, startDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!, endDate: Calendar.current.date(byAdding: .day, value: 10, to: Date())!, percent: 10),
//    Discount(id: UUID.init().uuidString, startDate: Date(), endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!, percent: 30),
//    Discount(id: UUID.init().uuidString, startDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!, endDate: Calendar.current.date(byAdding: .day, value: 10, to: Date())!, percent: 50),
//    Discount(id: UUID.init().uuidString, startDate: Date(), endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!, percent: 40)
//]
//
//
let products: [Product] = [
    Product(
        id: "prod1",
        name: "Apple iPhone 14",
        price: 999.99,
        categoryName: "Electronics",
        image: "iphone14.jpg",
        brandName: "Apple",
        shopName: "Amazon",
        discountIDs: ["pjBe6lcAEqxkvbTtW5Pi", "2sc7t5BDktgQjycwUpEm"]
    ),
    Product(
        id: "prod2",
        name: "Nike Air Max 270",
        price: 129.99,
        categoryName: "Footwear",
        image: "airmax270.jpg",
        brandName: "Nike",
        shopName: "Amazon",
        discountIDs: ["pjBe6lcAEqxkvbTtW5Pi"]
    ),
    Product(
        id: "prod3",
        name: "Samsung Galaxy S23",
        price: 899.99,
        categoryName: "Electronics",
        image: "galaxyS23.jpg",
        brandName: "Samsung",
        shopName: "Amazon",
        discountIDs: ["2sc7t5BDktgQjycwUpEm"]
    ),
    Product(
        id: "prod4",
        name: "Sony WH-1000XM5 Headphones",
        price: 349.99,
        categoryName: "Accessories",
        image: "sonyHeadphones.jpg",
        brandName: "Sony",
        shopName: "Amazon",
        discountIDs: ["pjBe6lcAEqxkvbTtW5Pi"]
    ),
    Product(
        id: "prod5",
        name: "Levi's 501 Original Jeans",
        price: 59.99,
        categoryName: "Clothing",
        image: "levis501.jpg",
        brandName: "Levi's",
        shopName: "Amazon",
        discountIDs: nil
    )
]
