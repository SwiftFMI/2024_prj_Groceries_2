//
//  Search.swift
//  Groceries
//
//  Created by Lazar Avramov on 11.02.25.
//

import SwiftUI

struct SearchTextFieldView: View {
    
    var placeholder: String = "Placeholder"
    @Binding var txt: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            TextField(placeholder, text: $txt)
                .font(.footnote)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .frame(height: 30)
        .padding(15)
        .background(Color.paleGray)
        .cornerRadius(16)
    }
    
}

struct SearchTextField_Previews: PreviewProvider {
    @State static var txt: String = ""
    static var previews: some View {
        SearchTextFieldView(placeholder: "Search Store", txt: $txt)
            .padding(15)
    }
}
