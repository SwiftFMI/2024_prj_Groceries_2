//
//  AddListView.swift
//  Groceries
//
//  Created by Yani Yankov on 2/18/25.
//

import Foundation
import SwiftUI

struct AddListViewL: View {
    @Binding var isPresented: Bool
    @State var listName: String = ""
    @EnvironmentObject var authViewModel: UserModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    authViewModel.addList(name: listName)
                    isPresented.toggle()
                } label: {
                    Text("Add")
                        .padding()
                        .foregroundStyle(.blue)
                }
                Spacer()
                Button {
                    isPresented = false
                } label: {
                    Text("Cancel")
                }
                .padding()
                .foregroundStyle(.blue)

            }
            TextField("Name your list", text: $listName, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .padding()
            Spacer()
        }
    }
}
