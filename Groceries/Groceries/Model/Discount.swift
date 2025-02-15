//
//  Discount.swift
//  Groceries
//
//  Created by Yani Yankov on 2/15/25.
//

import Foundation

struct Discount: Identifiable, Codable {
    let id: UUID
    let startDate: Date
    let endDate: Date
    let percent: Double
}
