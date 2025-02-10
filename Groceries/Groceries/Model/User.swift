//
//  User.swift
//  Shopping
//
//  Created by Lazar Avramov on 9.02.25.
//

import Foundation

struct User: Identifiable,Codable {
    let id: String
    let name: String
    let surname: String
    let email: String
    
    var initials: String {
       return  String(name.first ?? " ") + String(surname.first ?? " ")
    }
}

extension User {
    static var MOCK_USER = User(id:NSUUID().uuidString,
                                name:"Kristana",
                                surname:"Patrashkova",
                                email:"patrashkova@example.com")
}
