//
//  ProductBoxView.swift
//  Groceries
//
//  Created by Lazar Avramov on 11.02.25.
//

import SwiftUI

//TODO
struct ProductBoxView: View {
    @EnvironmentObject var userModel: UserModel
    @State var product: Product
    @State var amount: Int
    var didAddCart:( ()->() )?
//    var discountPrice: Double {
//        guard let percent = product.discounts?.percent else { return product.price }
//        return product.price - product.price * percent / 100
//    }
    
    @State var priceColor: Color = .gray
    
    private func getActualPrice() -> Double {
        var discounts:[Discount] = []
        var price = product.price
        let currDate = Date()
        Task{
            discounts = await userModel.fetchDiscounts(product: product)
        }
        
        for discount in discounts {
//            if discount.startDate <= currDate, discount.endDate >= currDate {
//                price -= product.price * discount.percent / 100
//            }
        }
        if price < product.price {
            priceColor = .green.opacity(50)
        }
        return price
    }
    
    var body: some View {
        VStack {
            Image(product.image)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 80)
            
            Spacer()
            
            Text(product.name)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            HStack{
                Text("$\(product.price, specifier: "%.2f" )")
//                    Text("$\(discountPrice, specifier: "%.2f" )")
                    .font(.system(size: 18, weight: .semibold))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(priceColor)
                    )
                    .foregroundColor(.white)
                               
                    Spacer()
                               
                VStack {
                    Text("\(amount)")
                    Button {
                        
                        didAddCart?()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                    }
                    .frame(width: 40, height: 40)
                    .background( Color.green)
                    .cornerRadius(15)
                }
            }
        }
        .padding(15)
        .frame(width: 180, height: 230)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
    }
}

struct ProductBoxView_Previews: PreviewProvider {
    static var previews: some View {
        ProductBoxView(product: .init(name: "Apple",
                                      price: 1.99,
                                      categoryName: "Fruits",
                                      image: "apples",
                                      brandName: "FreshFruits",
                                      discountIDs: [/*discountsMock[0].id, discountsMock[3].id*/]
//                                      startDate: Date(),
//                                      endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
//                                      offerPrice: 1.49))
                                     ),
                       amount: 5)
        
    }
}
