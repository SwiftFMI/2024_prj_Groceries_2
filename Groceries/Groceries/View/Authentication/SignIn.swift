//
//  SignIn.swift
//  Shopping
//
//  Created by Lazar Avramov on 9.02.25.
//

import SwiftUI

struct SignIn: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authViewModel:AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 120)
                    .padding(.vertical,32)
                
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email",
                              placeholder: "your_email@example.com",
                              isSecureField: false)
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "your_password",
                              isSecureField: true)
                    
                }
                .padding(.horizontal)
                .padding(.top,12)
                
                Button {
                    Task{
                        try await authViewModel.signIn(withEmail: email,
                                                        password: password)
                    }
                } label: {
                    HStack{
                        Text("Sign In")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width-32,height: 48)
    
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.00 : 0.4)
                .cornerRadius(30)
                .padding(.top,24)
                
                Spacer()
                
                NavigationLink {
                    SignUp()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack (spacing:4) {
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                }
                
            }
        }
    }
}

extension SignIn : Authenticatable {
    var formIsValid: Bool {
        return !email.isEmpty &&
        email.contains("@") &&
        !password.isEmpty &&
        password.count >= 6 &&
        password.contains(where: { $0.isNumber })
//        &&      password.contains(where: { $0.isLetter })
    }
}

#Preview {
    SignIn()
}
