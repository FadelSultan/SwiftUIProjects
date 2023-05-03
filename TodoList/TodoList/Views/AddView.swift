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
    
    @State private var alertTitle:String = ""
    @State private var isShowAlert:Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here ...", text: $textFieldText)
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
        .alert(isPresented: $isShowAlert, content: getAlert)
    }
    
    
    func saveButtonPressed(){
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your new todo item must to be at least 3 characters long!! 😅"
            isShowAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }.environmentObject(ListViewModel())
    }
}
