//
//  ContentView.swift
//  Groceries
//
//  Created by Lazar Avramov on 10.02.25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userController: UserController
    
    var body: some View {
        Group {
            if userController.userSession != nil {
                Profile()
            }
            else{
                SignIn()
            }
        }
    }
}

#Preview {
    ContentView()
}
