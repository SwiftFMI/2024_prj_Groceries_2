//
//  SignUp.swift
//  Shopping
//
//  Created by Lazar Avramov on 10.02.25.
//

import SwiftUI

struct SignUp: View {
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userController:UserController
    
    var body: some View {
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
                
                InputView(text: $name,
                          title: "Name",
                          placeholder: "John",
                          isSecureField: false)
                
                InputView(text: $surname,
                          title: "Surname",
                          placeholder: "Doe",
                          isSecureField: false)
                
                InputView(text: $password,
                          title: "Password",
                          placeholder: "your_password",
                          isSecureField: true)
                
                ZStack(alignment:.trailing) {
                    InputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "confirm_password",
                              isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
                
                Spacer()
                
                Button {
                    Task{
                        try await userController.signUp(withEmail: email,
                                                        password: password,
                                                        name: name,
                                                        surname: surname)
                    }
                } label: {
                    HStack{
                        Text("Sign  up")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width-32,height: 48)
                    
                }
                .background(Color(.systemBlue))
                .cornerRadius(30)
                .padding(.top,24)
                
            }
            .padding(.horizontal)
            .padding(.top,12)
            
            Spacer()
        
            Button {
                dismiss()
            } label: {
                HStack (spacing:4) {
                    Text("Already have account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
            }
            .font(.system(size:20))

        }
        
    }
}

#Preview {
    SignUp()
}
