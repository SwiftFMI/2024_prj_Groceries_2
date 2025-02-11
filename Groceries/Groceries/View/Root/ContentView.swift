//
//  ContentView.swift
//  Groceries
//
//  Created by Lazar Avramov on 10.02.25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                HomeView()
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
