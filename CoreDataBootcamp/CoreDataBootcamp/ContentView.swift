//
//  ContentView.swift
//  CoreDataBootcamp
//
//  Created by Fadel Sultan on 21/10/1444 AH.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \FruitsEntity.title,
            ascending: false)
        ],
        animation: .default)
    private var items: FetchedResults<FruitsEntity>
    
    @State private var textFiledText:String = ""

    var body: some View {
        NavigationView {
            
            VStack(spacing:20) {
                TextField("Add fruit here...", text: $textFiledText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    addItem()
                } label: {
                    Text("Save!".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.title ?? "Nothing")")
                        } label: {
                            Text(item.title ?? "Nothing")
                                .onTapGesture {
                                    update(fruit: item)
                                }
                        } 
                    }
                    .onDelete(perform: deleteItems)
                }.listStyle(PlainListStyle())

            }
            .navigationTitle("Fruits")
            
        }
        
    }

    private func addItem() {
        withAnimation {
            let newItem = FruitsEntity(context: viewContext)
            newItem.title = textFiledText.capitalized
            saveItems()
            textFiledText = ""
            
        }
    }

    private func update(fruit:FruitsEntity) {
        withAnimation {
            let current = fruit.title ?? ""
            let newName = current + "!"
            
            fruit.title = newName
            
            saveItems()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            saveItems()
        }
    }
    
    private func saveItems() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
