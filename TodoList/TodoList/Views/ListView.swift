//
//  ListView.swift
//  TodoList
//
//  Created by Fadel Sultan on 11/10/1444 AH.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject private var listViewModel:ListViewModel
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .padding(.top,40)
                    .transition(AnyTransition.opacity.animation(.easeIn))
            }else {
                List {
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.update(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
            }
        }
        .navigationTitle("Todo List 📝")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("Add", destination: AddView())
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(ListViewModel())
    }
}


