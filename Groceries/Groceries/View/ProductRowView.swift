//
//  ProductRowView.swift
//  Groceries
//
//  Created by Yani Yankov on 2/19/25.
//

import Foundation
import SwiftUI

struct ProductRowView: View {
    @EnvironmentObject var userModel: UserModel
    let product: Product
    let amount: Int

    @State var discountPrice: Double?
    
    private func calculateDiscount() {
        var price = product.price
        Task {
            var discounts:[Discount] = []
            
            let currDate = Date()
            
            discounts = await userModel.fetchDiscounts(product: product)
            
            for discount in discounts {
                if discount.startDate < currDate, discount.endDate > currDate {
                    price -= product.price * discount.percent / 100
                }
            }
        }
        
        DispatchQueue.main.async {
            self.discountPrice = price
        }
    }
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                    .tint(.black)
                Text(product.brandName)
                    .tint(.gray)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            if amount > 0 {
                Text("\(amount)")
                    .padding(10)
                    .background(
                        Circle()
                            .fill(.gray)
                    )
                    .foregroundColor(.white)
            }
            
            
            Spacer()
            if let discountPrice = self.discountPrice, discountPrice < self.product.price {
                
                Text("\(self.product.price, specifier: "%.2f")")
                    .strikethrough(true, color: .red)
                Text("\(discountPrice, specifier: "%.2f")")
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.green.opacity(50))
                    )
                    .foregroundColor(.white)
            } else {
                Text("\(self.product.price, specifier: "%.2f")")
            }
        }
        .onAppear {
            self.calculateDiscount()
        }
    }
}
