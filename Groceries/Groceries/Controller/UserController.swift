//
//  UserController.swift
//  Groceries
//
//  Created by Lazar Avramov on 10.02.25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol Authenticatable {
    var formIsValid:Bool { get }
}

@MainActor
class UserController: ObservableObject {
    @Published var user: User?
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email:String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            
        }
    }
    
    func signUp(withEmail email:String, password: String, name: String, surname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user =  User(id: result.user.uid, name: name, surname: surname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("Debug:failed to create user with error\(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.user = nil
        } catch {
            print("Debug:failed to sign out with error\(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        guard let user = Auth.auth().currentUser else { return }
              //TODO
    }
    
    func fetchUser() async  {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshotData = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.user = try? snapshotData.data(as: User.self)
    }
}
