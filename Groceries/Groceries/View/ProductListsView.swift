//
//  ProductListsView.swift
//  Groceries
//
//  Created by Yani Yankov on 2/15/25.
//

import Foundation
import SwiftUI

struct ProductListsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var listTabViewModel: ListTabViewModel
    
    var body: some View {
        NavigationStack(path: $listTabViewModel.navigationPath) {
            VStack {
                Text("\(viewModel.user?.name ?? "")'s Lists")
                    .fontWeight(.bold)
                    .font(.title)
                
                Spacer()
                if let productList = viewModel.userViewModel.user?.productLists {
                    List {
                        ForEach(productList, id: \.id) { list in
                            Button {
                                listTabViewModel.navigationPath.append(list)
                            } label: {
                                Text(list.name)
                                    .foregroundStyle(.primary)
                            }
                            .contentShape(Rectangle())
                        }
                    }
                }
            }
            .navigationDestination(for: ProductList.self) { productList in
                SingleListView(list: productList)
                    .padding(.top)
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            HStack {
                                Image(systemName: "chevron.backward")
                                    .foregroundStyle(Color.accentColor)
                                Button("All Lists") {
                                    listTabViewModel.navigationPath.removeLast()
                                }
                            }
                            .padding()
                        }
                    }
            }
            .navigationDestination(for: Product.self) { product in
                Text(":P")
            }
        }
    }
}

