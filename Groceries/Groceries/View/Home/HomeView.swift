//
//  HomeView.swift
//  Groceries
//
//  Created by Lazar Avramov on 11.02.25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel: HomeViewModel = .shared
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                }
                SearchTextFieldView(placeholder: "Search store", txt: $homeViewModel.txtSearch)
                    .padding(.horizontal, 20)
                    .padding(.vertical,8)
            }
            .padding(.top)
            
            TitleTextFieldView(title: "Exclusive offer", titleAll: "See All") {
                         
            }
            .padding(.horizontal, 20)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    //TODO Връзка с offerArr за дисплейване на продукти които са оферта
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
