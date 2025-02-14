//
//  MainTabView.swift
//  Groceries
//
//  Created by Lazar Avramov on 11.02.25.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var homeViewMOdel = HomeViewModel.shared
    
    var body: some View {
        VStack {
            TabView(selection: $homeViewMOdel.selectTab) {
                HomeView().tag(0)
                ExploreView().tag(1)
                ExploreView().tag(2)
                ExploreView().tag(3)
                ExploreView().tag(4)
            }
            .onAppear{
                UIScrollView.appearance().isScrollEnabled = false
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: homeViewMOdel.selectTab) { newValue in
                debugPrint("Sel tab:|\(newValue)|\n")
            }
            
            HStack {
                TabButtonView(title: "Stores",
                              icon: "storefront.fill",
                              isSelect: homeViewMOdel.selectTab == 0){
                    DispatchQueue.main.async {
                        withAnimation {
                            homeViewMOdel.selectTab = 0
                        }
                    }
                }
                TabButtonView(title: "Cart",
                              icon: "cart.fill",
                              isSelect: homeViewMOdel.selectTab == 1){
                    DispatchQueue.main.async {
                        withAnimation {
                            homeViewMOdel.selectTab = 1
                        }
                    }
                }
                TabButtonView(title: "Explore",
                              icon: "magnifyingglass",
                              isSelect: homeViewMOdel.selectTab == 2){
                    DispatchQueue.main.async {
                        withAnimation {
                            homeViewMOdel.selectTab = 2
                        }
                    }
                }
                TabButtonView(title: "Account",
                              icon: "person.crop.circle",
                              isSelect: homeViewMOdel.selectTab == 3){
                    DispatchQueue.main.async {
                        withAnimation {
                            homeViewMOdel.selectTab = 3
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    MainTabView()
}
