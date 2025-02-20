//
//  AddProductView.swift
//  Groceries
//
//  Created by Yani Yankov on 2/18/25.
//

import Foundation
import SwiftUI

struct AddProductView: View {
    @Binding var list: ProductList
    @Binding var isPresented: Bool
    @EnvironmentObject var userModel: UserModel
    @State  var searchQuery: String = ""
    @State var searchResults: [Product] = []
    @State  var isLoading: Bool = false
    @State var showNotification: Bool = false
    @State var isButtonDisabled: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        isPresented = false
                    } label: {
                        Text("Cancel")
                    }
                    .padding()
                    .foregroundStyle(.blue)
                    Spacer()
                }
                
                VStack {
                    TextField("Search for a product", text: $searchQuery)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: searchQuery) { newValue in
                            Task {
                                await self.performSearch(query: newValue)
                            }
                        }
                    
                    if isLoading {
                        ProgressView()
                            .padding()
                    }
                    
                    List {
                        ForEach(self.$searchResults, id: \.self) { product in
                            HStack {
                                ProductRowView(product: product.wrappedValue, amount: 0)
                                Spacer()
                                Button {
                                    userModel.addProductToList(list: self.list, product: product.wrappedValue, amount: 1)
                                    showPurchaseNotification()
                                } label: {
                                    Image(systemName: "plus")
                                        .scaledToFit()
                                        .foregroundStyle(Color.white)
                                }
                                .disabled(isButtonDisabled)
                                .buttonStyle(.borderedProminent)
                                .foregroundStyle(Color.blue.opacity(0.5))
                            }
                            
                        }
                    }
                }
            }
            if showNotification {
                           NotificationView()
                               .transition(.move(edge: .top).combined(with: .opacity))
                               .zIndex(1)
                       }
        }
    }
    
    private func performSearch(query: String) async {
        guard !query.isEmpty else {
            self.searchResults = []
            return
        }
        
        isLoading = true
        searchResults = await userModel.searchProducts(byName: query)
        isLoading = false
    }
    
    func showPurchaseNotification() {
          withAnimation {
              showNotification = true
              isButtonDisabled = true
              
          }
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              withAnimation {
                  showNotification = false
                  isButtonDisabled = false
              }
          }
      }
}

struct NotificationView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Item Added to List!")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
