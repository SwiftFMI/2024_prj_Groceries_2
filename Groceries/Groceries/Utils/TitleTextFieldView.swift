//
//  TitleTextFieldView.swift
//  Groceries
//
//  Created by Lazar Avramov on 14.02.25.
//

import SwiftUI

struct TitleTextFieldView: View {
    @State var title: String = " Title"
    @State var titleAll: String = "View All"
    var didTap : (()->())?
        
    var body: some View {
            
        HStack{
            Text(title)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.black)
                
            Spacer()
                
            Text(titleAll)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.green)
                
            }
            .frame(height: 40)
        }
}

struct TitleTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TitleTextFieldView()
            .padding(20)
    }
}
