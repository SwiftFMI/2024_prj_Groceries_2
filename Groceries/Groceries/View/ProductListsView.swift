//
//  ProductListsView.swift
//  Groceries
//
//  Created by Yani Yankov on 2/15/25.
//

import Foundation
import SwiftUI

struct ProductListsView: View {
    @EnvironmentObject var viewModel: UserModel
    @State var isAddListSheetPresented: Bool = false
    @State var showNotification: Bool = false
    @State var isRemoveButtonDisabled: Bool = false
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                VStack {
                    Text("\(viewModel.user?.name ?? "")'s Lists")
                        .fontWeight(.bold)
                        .font(.title)
                    
                    Spacer()
                    ZStack {
                        List {
                            if let productList = viewModel.user?.productLists {
                                
                                ForEach(productList, id: \.id) { list in
                                    HStack {
                                        Button {
                                            viewModel.navigationPath.append(list.id)
                                        } label: {
                                            Text(list.name)
                                                .foregroundStyle(.primary)
                                        }
                                        .contentShape(Rectangle())
                                        
                                        Spacer()
                                        
                                        Button {
                                            self.viewModel.removeList(name: list.name)
                                            showRemoveNotification()
                                        } label: {
                                            Image(systemName: "minus")
                                                .scaledToFit()
                                                .foregroundStyle(Color.white)
                                                .padding(5)
                                        }
                                        .disabled(self.isRemoveButtonDisabled)
                                        .buttonStyle(.bordered)
                                        .background(Color.red)
                                        .cornerRadius(10)
                                    }
                                }
                            }
                        }
                        VStack{
                            Spacer()
                            HStack {
                                Spacer()
                                Button {
                                    isAddListSheetPresented.toggle()
                                } label: {
                                    Image(systemName: "plus.square.fill")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .padding()
                                        .foregroundColor(.blue)
                                }
                                .sheet(isPresented: $isAddListSheetPresented) {
                                    AddListViewL(isPresented: $isAddListSheetPresented)
                                        .presentationDetents([.medium])
                                        .presentationDragIndicator(.automatic)
                                }
                            }
                        }
                        
                    }
                }
                .navigationDestination(for: String.self) { id in
                    if let list = viewModel.user?.productLists?.first(where: { $0.id == id }) {
                        SingleListView(list: list)
                    }
                }
                
                if showNotification {
                    NotificationView(text: "List Deleted!")
                                   .transition(.move(edge: .top).combined(with: .opacity))
                                   .zIndex(1)
                           }
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

