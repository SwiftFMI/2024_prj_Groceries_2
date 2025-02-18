//
//  AddProductView.swift
//  Groceries
//
//  Created by Lazar Avramov on 18.02.25.
//

import SwiftUI

struct AddProductView: View {
    @State private var name: String = ""
    @State private var brand: String = ""
    @State private var price: Double = 0.0
    @State private var image:  String = ""
    @EnvironmentObject var productViewModel: ProductViewModel
    var body: some View {
        VStack(spacing: 16) {
            TextField("Product Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Brand", text: $brand)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("ImageUrl", text: $image)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Price", value: $price, format: .number)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            
            Button {
                Task{
                    try await productViewModel.createProduct(name: name, price: price, image: image, shopName: brand)
                }
            } label: {
                HStack{
                    Text("Create product")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.blue)
                .frame(width: UIScreen.main.bounds.width-32,height: 48)
                
            }
        }
    }
}

#Preview {
    AddProductView()
}
