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
    @EnvironmentObject var userViewModel: UserModel
    @State var isAddProductSheetPresented: Bool = false
    @State var showNotification: Bool = false
    @State var isRemoveButtonDisabled:  Bool = false
    
    var products: [ProductAmount] {
        var pairs: [ProductAmount] = []
        if let productIDs = userViewModel.user?.productLists?.first(where: { $0.id == list.id })?.productIDs {
            let productModels = userViewModel.userItems.products.filter { productIDs.keys.contains($0.id) }
            productModels.forEach { product in
                if let amount = productIDs[product.id] {
                    pairs.append(ProductAmount(product: product, amount: amount))
                }
            }
        }
        return pairs
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(list.name)")
                    .fontWeight(.bold)
                    .font(.title)
                ZStack {
                    List {
                        ForEach(self.products, id: \.self) { product in
                            HStack {
                                ProductRowView(product: product.product, amount: product.amount)
                                Spacer()
                                Button {
                                    print("pressed")
                                    userViewModel.removeProductFromList(list: self.list, product: product.product)
                                    showRemoveNotification()
                                } label: {
                                    Image(systemName: "minus")
                                        .scaledToFit()
                                        .foregroundStyle(Color.white)
                                        .padding(5)
                                }
                                .disabled(isRemoveButtonDisabled)
                                .buttonStyle(.bordered)
                                .background(Color.red)
                                .cornerRadius(10)
                            }
                        }
                    }
                    VStack{
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                isAddProductSheetPresented.toggle()
                            } label: {
                                Image(systemName: "plus.square.fill")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .padding()
                                    .foregroundColor(.blue)
                                    .shadow(color: .gray, radius: 5, x: 5, y: 5)
                            }
                            .sheet(isPresented: $isAddProductSheetPresented) {
                                AddProductView(list: $list, isPresented: $isAddProductSheetPresented)
                                
                            }
                            .presentationDetents([.large])
                            .presentationDragIndicator(.automatic)
                        }
                    }
                }
            }
            if showNotification {
                NotificationView(text: "Item Removed from List!")
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
            }
        }
    }
    
     func showRemoveNotification() {
        withAnimation {
            showNotification = true
            isRemoveButtonDisabled = true
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                showNotification = false
                isRemoveButtonDisabled = false
            }
        }
    }
        
}
