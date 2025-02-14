//
//  ProductBoxView.swift
//  Groceries
//
//  Created by Lazar Avramov on 11.02.25.
//

import SwiftUI

//TODO
struct ProductBoxView: View {
    @State var product: Product
    var didAddCart:( ()->() )?
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
                    Text("$\(product.offerPrice ?? product.price, specifier: "%.2f" )")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                               
                    Spacer()
                               
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
                                      image: "apples",
                                      categoryName: "Fruits",
                                      brandName: "FreshFruits",
                                      startDate: Date(),
                                      endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
                                      offerPrice: 1.49))
        
    }
}
