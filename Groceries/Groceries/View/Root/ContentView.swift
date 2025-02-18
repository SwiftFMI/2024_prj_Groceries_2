//
//  ContentView.swift
//  Groceries
//
//  Created by Lazar Avramov on 10.02.25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
//    var userViewModel: UserViewModel = UserViewModel(user: nil)
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
//                HomeView()
                MainTabView()
            }
            else{
                SignIn()
            }
        }
//        .onAppear {
//            if authViewModel.userSession != nil {
//                let newUser = authViewModel.user
//                        self.userViewModel.updateUser(user: newUser)
//                        self.userViewModel.user?.productLists = [
//                            ProductList(id: UUID.init().uuidString, name: "Test", productIDs: productMock1.map { Product in
//                                Product.id
//                            }),
//                            ProductList(id: UUID.init().uuidString, name: "Test", productIDs: productMock2.map { Product in
//                                Product.id
//                            }),
//                            ProductList(id: UUID.init().uuidString, name: "Test", productIDs: productMock3.map { Product in
//                                Product.id
//                            })
//                        ]
//                    }
//                }
    }
}

//#Preview {
//    ContentView()
//}
