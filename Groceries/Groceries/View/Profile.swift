//
//  Profile.swift
//  Shopping
//
//  Created by Lazar Avramov on 10.02.25.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var userController: UserController
    var body: some View {
        if let user = userController.user {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72,height: 72)
                            .background(Color(.systemGray))
                            .clipShape(Circle())
                    
                        VStack(alignment: .leading,spacing: 4) {
                            Text(user.name + " " + user.surname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top,4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
                Section ("Account") {
                    Button {
                        userController.signOut()
                    } label: {
                        SettingsRowView(imageName: "delete.left.fill",
                                        title: "Sign out",
                                        tintColor: .red)
                    }
                    
                    Button {
                        print("Delete account")
                    } label: {
                        SettingsRowView(imageName: "person.crop.circle.badge.xmark",
                                        title: "Delete Account",
                                        tintColor: .red)
                    }
                    
                }
            }

        }
    }
}

#Preview {
    Profile()
}
