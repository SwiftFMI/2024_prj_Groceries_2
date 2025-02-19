//
//  ContentView.swift
//  Groceries
//
//  Created by Lazar Avramov on 10.02.25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: UserModel
    
    var body: some View {
        Group {
            if authViewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                if authViewModel.userSession != nil {
                    MainTabView()
                }
                else{
                    SignIn()
                }
            }
        }

    }
}
