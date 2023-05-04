//
//  ListRowView.swift
//  TodoList
//
//  Created by Fadel Sultan on 11/10/1444 AH.
//

import SwiftUI

struct ListRowView: View {
    
    let item:ItemModel
    var body: some View {
        HStack {
            Image(systemName: item.isComplete ? "checkmark.circle" : "circle")
                .foregroundColor(item.isComplete ? Color.green : Color.red)
            Text(item.title)
            Spacer()
        }
        .padding(.vertical,8)
        .font(.title3)
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        let item1 = ItemModel(title: "This is frist item in the list ", isComplete: false)
        
        let item2 = ItemModel(title: "This is second item", isComplete: true)
        
        Group {
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
