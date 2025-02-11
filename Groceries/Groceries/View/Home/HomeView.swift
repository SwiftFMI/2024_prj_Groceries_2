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
        }
    }
}

#Preview {
    HomeView()
}
