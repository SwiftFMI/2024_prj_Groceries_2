//
//  GroceriesApp.swift
//  Groceries
//
//  Created by Lazar Avramov on 10.02.25.
//

import SwiftUI
import Firebase

@main
struct GroceriesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var authViewModel = UserModel()
//    let userViewModel = UserViewModel(user: nil)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
//                .environmentObject(userViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    

    return true
  }
}
