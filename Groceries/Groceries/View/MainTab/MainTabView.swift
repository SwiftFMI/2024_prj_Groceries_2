//
//  MainTabView.swift
//  Groceries
//
//  Created by Lazar Avramov on 11.02.25.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            TabView(selection: $homeViewModel.selectTab) {
                HomeView().tag(0)
//                ExploreView().tag(1)
                ProductListsView().tag(1)
                ExploreView().tag(2)
                Profile().tag(3)
//                ExploreView().tag(4)
            }
            .onAppear{
                UIScrollView.appearance().isScrollEnabled = false
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: homeViewModel.selectTab) { newValue in
                debugPrint("Sel tab:|\(newValue)|\n")
            }
            
            HStack {
                TabButtonView(title: "Stores",
                              icon: "storefront.fill",
                              isSelect: homeViewModel.selectTab == 0){
                        withAnimation {
                            homeViewModel.selectTab = 0
                        }
                }
                TabButtonView(title: "Cart",
                              icon: "cart.fill",
                              isSelect: homeViewModel.selectTab == 1){
                        withAnimation {
                            homeViewModel.selectTab = 1
                        }
                }
                TabButtonView(title: "Explore",
                              icon: "magnifyingglass",
                              isSelect: homeViewModel.selectTab == 2) {
                        withAnimation {
                            homeViewModel.selectTab = 2
                        }
                }
                TabButtonView(title: "Account",
                              icon: "person.crop.circle",
                              isSelect: homeViewModel.selectTab == 3) {
                        withAnimation {
                            homeViewModel.selectTab = 3
                    }
                }
            }
        }
        
    }
}

#Preview {
    MainTabView()
}
