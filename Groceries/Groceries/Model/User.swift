//
//  User.swift
//  Shopping
//
//  Created by Lazar Avramov on 9.02.25.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let surname: String
    let email: String
    
    var productLists: [ProductList]?
    
    var initials: String {
       return  String(name.first ?? " ") + String(surname.first ?? " ")
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
