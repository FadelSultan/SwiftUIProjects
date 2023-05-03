//
//  ListViewModel.swift
//  TodoList
//
//  Created by Fadel Sultan on 11/10/1444 AH.
//

import Foundation

class ListViewModel:ObservableObject {
    
    @Published var items:[ItemModel] = [] {
        didSet {
            saveToUserDefault()
        }
    }
    
    private let listKey:String = "List_Item"
    
    init(){
        getItems()
    }
    
    func getItems() {

        guard
            let data = UserDefaults.standard.data(forKey: listKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from:  data)
        else {return}
        
        items = savedItems
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
    
    func update(item: ItemModel) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveToUserDefault() {
        if let encodeData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodeData, forKey: listKey)
        }
    }
}
