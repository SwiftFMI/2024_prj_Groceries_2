//
//  ProductView.swift
//  Groceries
//
//  Created by Lazar Avramov on 14.02.25.
//


//TODO
import SwiftUI

struct ProductView: View {
    @EnvironmentObject var listTabViewModel: ListTabViewModel
    let product: Product
    var body: some View {
        Text("ProductID: \(product.id)")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(Color.accentColor)
                        Button("Back") {
                            self.listTabViewModel.navigationPath.removeLast()
                        }
                    }
                    .padding()
                }
            }
    }
}

