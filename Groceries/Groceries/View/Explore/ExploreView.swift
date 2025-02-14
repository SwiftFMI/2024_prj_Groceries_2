//
//  ExploreView.swift
//  Groceries
//
//  Created by Lazar Avramov on 11.02.25.
//

import SwiftUI

struct ExploreView: View {
    @StateObject var exploreViewModel: ExploreViewModel = .shared
    @State var txtSearch: String = ""
    
    
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("Find Products")
                        .font(.system(size: 20, weight: .bold))
                        .frame(height: 40)
                    Spacer()
                    
                }
                .padding(.top)
                
                SearchTextFieldView(placeholder: "Serch", txt: $txtSearch)
                    .padding(.horizontal,20)
                    .padding(.vertical,10)
                
                Spacer()
                
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
        .padding(20)
    }
}
