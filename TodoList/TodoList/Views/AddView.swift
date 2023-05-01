//
//  AddView.swift
//  TodoList
//
//  Created by Fadel Sultan on 11/10/1444 AH.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var listViewModel:ListViewModel
    
    @State private var textFieldText:String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type somthing here ...", text: $textFieldText)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .frame(height: 55)
                .cornerRadius(10)
                
                Button(action: saveButtonPressed) {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }

                
            }
            .padding()
                
                
        }
        .navigationTitle("Add an item ✏️")
    }
    
    
    func saveButtonPressed(){
        listViewModel.addItem(title: textFieldText)
        dismiss()
    }
    
    func textIsAppropriate() -> Bool {
        return textFieldText.count > 3
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }.environmentObject(ListViewModel())
    }
}
