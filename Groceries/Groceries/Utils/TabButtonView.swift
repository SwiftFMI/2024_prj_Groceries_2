//
//  TabButtonView.swift
//  Groceries
//
//  Created by Lazar Avramov on 11.02.25.
//

import SwiftUI

struct TabButtonView: View {
        @State var title: String = "Title"
        @State var icon: String = "storefront.fill"
        var isSelect: Bool = false
        var didSelect: (()->())
       
        var body: some View {
           Button {
               debugPrint("Tab Button Tap")
               didSelect()
           } label: {
               VStack{
                   Image(systemName: icon)
                       .resizable()
                       .scaledToFit()
                       .frame(width: 25, height: 25)
                   
                   
                   Text(title)
                       .font(.footnote)
                   
                       
               }
           }
           .foregroundColor(isSelect ? .green : .black)
           .frame(minWidth: 0, maxWidth: .infinity)
       }
}

struct TabButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TabButtonView {
            print("Test")
        }
    }
}
