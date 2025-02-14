//
//  ExploreViewModel.swift
//  Groceries
//
//  Created by Lazar Avramov on 14.02.25.
//

import SwiftUI

class ExploreViewModel: ObservableObject {
    static var shared: ExploreViewModel = ExploreViewModel()
    
    @Published var selectTab:Int = 0
    @Published var txtSearch:String = ""
    
    @Published var listArr: [ExploreCategory] = []
    
}


