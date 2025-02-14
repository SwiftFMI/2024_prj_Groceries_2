//
//  ExploreCategory.swift
//  Groceries
//
//  Created by Lazar Avramov on 14.02.25.
//

import Foundation

struct ExploreCategory: Identifiable,Codable {
    let id:String
    let name:String
    var image:String = ""
    
    init(id: String = UUID().uuidString,
             name: String,
         image: String = ""){
        self.id = id
        self.name = name
        self.image = image
    }
}
