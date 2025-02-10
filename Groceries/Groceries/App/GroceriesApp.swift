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
    @StateObject var userController = UserController()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userController)
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
