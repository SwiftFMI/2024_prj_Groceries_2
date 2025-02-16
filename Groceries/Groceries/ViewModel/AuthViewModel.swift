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
class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var userViewModel: UserViewModel = UserViewModel(user: nil)
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
//        guard let user = Auth.auth().currentUser else { return }
              //TODO
    }
    
    func fetchUser() async  {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshotData = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {
            return
        }
        if let rawData = snapshotData.data() {
            print(rawData)
        } else {
            print("No Raw data")
        }
        self.user = try? snapshotData.data(as: User.self)
        
//        self.user?.productLists = [
//            ProductList(id: UUID.init().uuidString, name: "List1", productIDs: [productMock1[0].id : 3,
//                                                                                productMock1[1].id : 3
//                                                                               ]),
//            ProductList(id: UUID.init().uuidString, name: "List2", productIDs: [productMock2[0].id : 2,
//                                                                                productMock2[1].id : 5,
//                                                                                productMock2[2].id : 1
//                                                                               ]),
//            ProductList(id: UUID.init().uuidString, name: "List3", productIDs: [productMock3[0].id : 20])
//        ]
        
        self.userViewModel.updateUser(user: self.user)
    }
}
