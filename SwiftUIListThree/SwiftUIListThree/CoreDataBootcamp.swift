//
//  CoreDataBootcamp.swift
//  SwiftUIListThree
//
//  Created by Fadel Sultan on 22/10/1444 AH.
//

import SwiftUI
import CoreData


class CoreDateManager:ObservableObject {
    // View
//    Model
//    ModelView
    
    //Variables to difination Coredata
    let container:NSPersistentContainer
    @Published var savedEntity:[FruitsEntity] = []
//    setup core data
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("There is an error when load data from core data: \(error)")
            }
        }
        fetchData()
    }
    //functions to manages
    
    //Fetch data
    private func fetchData() {
        let request = NSFetchRequest<FruitsEntity>(entityName: "FruitsEntity")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \FruitsEntity.name, ascending: false)]
        do {
            savedEntity = try container.viewContext.fetch(request)
        }catch let error {
            print("There is an error when fetch data: \(error.localizedDescription)")
        }
    }
    //add
    func addFruit(name:String) {
        let newFruit = FruitsEntity(context: container.viewContext)
        newFruit.name = name
        saveData()
    }
    //update
    func update(fruitEntity:FruitsEntity) {
        let currentName = fruitEntity.name ?? ""
        let newName = currentName + "!"
        fruitEntity.name = newName
        saveData()
    }
    //delete
    
    func deleteFruit(indexSet:IndexSet) {
        guard let index = indexSet.first else {return}
        let entity = savedEntity[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    //savedata
    
    private func saveData() {
        do {
            try container.viewContext.save()
            fetchData()
        }catch let error {
            print("There is an error when saved data: \(error.localizedDescription)")
        }
    }
}


let myColor = Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1))


struct CoreDataBootcamp: View {
    
    @StateObject private var mv = CoreDateManager()
    
    @State private var textFiledFruitName:String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1))
                    .ignoresSafeArea()
                
                VStack (spacing:10){
                    TextField("Add fruit here..", text: $textFiledFruitName)
                        .font(.headline)
                        .frame(height: 50)
                        .padding(.leading)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                    Button {
                        mv.addFruit(name: textFiledFruitName)
                        textFiledFruitName = ""
                    } label: {
                        Text("Save".uppercased())
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }

                    List {
                        ForEach(mv.savedEntity) { fruit in
                            Text(fruit.name ?? "")
                                .onTapGesture {
                                    mv.update(fruitEntity: fruit)
                                }
                        }
                        .onDelete(perform: mv.deleteFruit)
                    }
                    
                    Spacer()
                }
                
                
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
