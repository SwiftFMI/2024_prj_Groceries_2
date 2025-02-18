//
//  ProductBoxView.swift
//  Groceries
//
//  Created by Lazar Avramov on 11.02.25.
//

import SwiftUI
import SDWebImageSwiftUI

//TODO
struct ProductBoxView: View {
    @State var product: Product
    var didAddCart:( ()->() )?
    var body: some View {
        VStack {
            WebImage(url: URL(string: product.image ))
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
                    Text("$\( product.price, specifier: "%.2f" )")
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
                                      image:"https://assets.clevelandclinic.org/transform/LargeFeatureImage/cd71f4bd-81d4-45d8-a450-74df78e4477a/Apples-184940975-770x533-1_jpg",
                                      shopName: "FreshFruits"))
    }
}
