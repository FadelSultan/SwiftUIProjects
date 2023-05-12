//
//  CoreDataBootcampApp.swift
//  CoreDataBootcamp
//
//  Created by Fadel Sultan on 21/10/1444 AH.
//

import SwiftUI

@main
struct CoreDataBootcampApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
