//
//  ProductListView.swift
//  Groceries
//
//  Created by Yani Yankov on 2/15/25.
//

import Foundation
import SwiftUI

struct SingleListView: View {
    @State var list: ProductList
    @EnvironmentObject var listTabViewModel: ListTabViewModel
    @EnvironmentObject var authViewMode: AuthViewModel
    
    var body: some View {
            VStack {
                Text("\(list.name)")
                    .fontWeight(.bold)
                    .font(.title)
                List {
                    if let productIDs = list.productIDs {
                        ForEach(Array(productIDs.keys), id: \.self) { product in
                            Button {
                                let test = authViewMode.userViewModel.userListProducts.products
                                if let prod = authViewMode.userViewModel.userListProducts.products.first(where: { $0.id == product }) {
                                    listTabViewModel.navigationPath.append(prod)
                                }
                            } label: {
                                HStack {
                                    Text(product)
                                }
                            }
                            //                        ProductBoxView(product: product)
                            ////                            .frame(width: 300, height: 200, alignment: .center)
                            ////                            .background(Color(.red))
                        }
                    }
                }
            }
            .navigationDestination(for: Product.self) { product in
                Text(":P")
            }
//        }
    }
}
