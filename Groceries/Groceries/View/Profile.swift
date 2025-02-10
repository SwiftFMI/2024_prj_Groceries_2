//
//  Profile.swift
//  Shopping
//
//  Created by Lazar Avramov on 10.02.25.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Text(User.MOCK_USER.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72,height: 72)
                        .background(Color(.systemGray))
                        .clipShape(Circle())
                
                    VStack(alignment: .leading,spacing: 4) {
                        Text(User.MOCK_USER.name + " " + User.MOCK_USER.surname)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top,4)
                        
                        Text(User.MOCK_USER.email)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }
            Section ("Account") {
                Button {
                    print("Sign out")
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

#Preview {
    Profile()
}
