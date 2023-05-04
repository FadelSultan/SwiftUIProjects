//
//  TodoListApp.swift
//  TodoList
//
//  Created by Fadel Sultan on 11/10/1444 AH.
//

import SwiftUI

@main
struct TodoListApp: App {
    
    @StateObject private var listViewModel:ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
        }
    }
}
