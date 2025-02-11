//
//  HomeViewModel.swift
//  Groceries
//
//  Created by Lazar Avramov on 11.02.25.
//

import Foundation
import SwiftUI

class HomeViewModel : ObservableObject {
    static let shared = HomeViewModel()
    @Published var selectTab: Int = 0
    @Published var txtSearch: String = ""
        
        private init() {}
    
}

