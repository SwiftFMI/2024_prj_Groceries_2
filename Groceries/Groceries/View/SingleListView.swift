//
//  ProductListView.swift
//  Groceries
//
//  Created by Yani Yankov on 2/15/25.
//

import Foundation
import SwiftUI

struct ProductAmount: Hashable {
    let product: Product
    var amount: Int
}

struct SingleListView: View {
    @State var list: ProductList
    @EnvironmentObject var listTabViewModel: ListTabViewModel
    @EnvironmentObject var authViewMode: UserModel
    
    var products: [ProductAmount] {
        var pairs: [ProductAmount] = []
        if let productIDs = list.productIDs {
            let productModels = authViewMode.userItems.products.filter { productIDs.keys.contains($0.id) }
            productModels.forEach { product in
                if let amount = productIDs[product.id] {
                    pairs.append(ProductAmount(product: product, amount: amount))
                }
            }
        }
        return pairs
    }
    
    
    
    var body: some View {
        VStack {
            Text("\(list.name)")
                .fontWeight(.bold)
                .font(.title)
            List {
                ForEach(self.products, id: \.self) { product in
                    Button {
                        listTabViewModel.navigationPath.append(product.product)
                    } label: {
                        ProductRowView(product: product.product, amount: product.amount)
                    }
                }
            }
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
    }
}
