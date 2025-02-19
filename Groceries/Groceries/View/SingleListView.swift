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
    @EnvironmentObject var authViewMode: UserModel
    
    var body: some View {
            VStack {
                Text("\(list.name)")
                    .fontWeight(.bold)
                    .font(.title)
                List {
                    if let productIDs = list.productIDs {
                        ForEach(Array(productIDs.keys), id: \.self) { product in
                            Button {
                                if let prod = list.productIDs?.first(where: { $0.key == product }) {
                                    listTabViewModel.navigationPath.append(prod.key)
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
            .navigationDestination(for: String.self) { productID in
                Text("ProductID: \(productID)")
            }
//            .navigationDestination(for: Product.self) { product in
//                Text(":P")
//            }
//        }
    }
}
