//
//  ListViewModel.swift
//  TodoList
//
//  Created by Fadel Sultan on 11/10/1444 AH.
//

import Foundation

class ListViewModel:ObservableObject {
    
   @Published var items:[ItemModel] = []
    init(){
        getItems()
    }
    
    func getItems() {
        let newItems = [
            ItemModel(title: "This is first item in the list", isComplete: false),
            ItemModel(title: "This is second item!", isComplete: true),
            ItemModel(title: "Third item", isComplete: false)
        ]
        
        items.append(contentsOf: newItems)
    }
    
    func deleteItem(indexSet:IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from:IndexSet , to:Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title:String) {
        items.append(
            ItemModel(title: title, isComplete: false)
        )
    }
}
