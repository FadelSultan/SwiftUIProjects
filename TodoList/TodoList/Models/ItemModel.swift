//
//  ItemModel.swift
//  TodoList
//
//  Created by Fadel Sultan on 11/10/1444 AH.
//

import Foundation

struct ItemModel:Identifiable {
    var id:String = UUID().uuidString
    var title:String
    var isComplete:Bool
}
