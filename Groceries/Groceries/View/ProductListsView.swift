//
//  ProductListsView.swift
//  Groceries
//
//  Created by Yani Yankov on 2/15/25.
//

import Foundation
import SwiftUI

struct ProductListsView: View {
    @EnvironmentObject var viewModel: UserModel
    @EnvironmentObject var listTabViewModel: ListTabViewModel
    @State var isAddListSheetPresented: Bool = false
    
    var body: some View {
        NavigationStack(path: $listTabViewModel.navigationPath) {
            VStack {
                Text("\(viewModel.user?.name ?? "")'s Lists")
                    .fontWeight(.bold)
                    .font(.title)
                
                Spacer()
                ZStack {
                    List {
                        if let productList = viewModel.user?.productLists {
                            
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
                    VStack{
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                isAddListSheetPresented.toggle()
                            } label: {
                                Image(systemName: "plus.square.fill")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .padding()
                                    .foregroundColor(.blue)
                                    .shadow(color: .gray, radius: 5, x: 5, y: 5)
                            }
                            .sheet(isPresented: $isAddListSheetPresented) {
                                AddListViewL(isPresented: $isAddListSheetPresented)
                                    .presentationDetents([.medium])
                                    .presentationDragIndicator(.automatic)
                            }
                        }
                    }

                }
            }
            .navigationDestination(for: ProductList.self) { productList in
                SingleListView(list: productList)
            }
            .navigationDestination(for: Product.self) { product in
                ProductView(product: product)
            }
        }
    }
}

