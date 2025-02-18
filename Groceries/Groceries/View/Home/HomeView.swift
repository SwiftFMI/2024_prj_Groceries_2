//
//  HomeView.swift
//  Groceries
//
//  Created by Lazar Avramov on 11.02.25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel: HomeViewModel = .shared
    @EnvironmentObject var productViewModel: ProductViewModel
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
                    if productViewModel.products.isEmpty {
                                        ProgressView("Loading products...")
                                            .padding()
                                    } else {
                                        // Вместо List, използваме ForEach
                                        ForEach(productViewModel.products) { product in
                                            ProductBoxView(product: product, didAddCart: {
                                                // Логика за добавяне в количка
                                            })
                                            .padding(.leading, 16)
                                        }
                    }
                }
            }
            .onAppear() {
                Task {
                    await productViewModel.fetchProducts()
                    print("Fetchnahme")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
