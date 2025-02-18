//
//  Profile.swift
//  Shopping
//
//  Created by Lazar Avramov on 10.02.25.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        if let user = authViewModel.user {
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
                        authViewModel.signOut()
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
                ProductBoxView(product: .init(name: "Apple",
                                              price: 1.99,
                                              image: "apples",
                                              categoryName: "Fruits",
                                              brandName: "FreshFruits",
                                              discountIDs: [discountsMock[0].id, discountsMock[3].id]
                                              //                                      startDate: Date(),
        //                                      endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
        //                                      offerPrice: 1.49))
                                             ))
            }

        }
    }
}

#Preview {
    Profile()
}
