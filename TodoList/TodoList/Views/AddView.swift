//
//  AddView.swift
//  TodoList
//
//  Created by Fadel Sultan on 11/10/1444 AH.
//

import SwiftUI

struct AddView: View {
    
    @State private var textFieldText:String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type somthing here ...", text: $textFieldText)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .frame(height: 55)
                .cornerRadius(10)
                
                Button {
                    
                } label: {
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
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }
    }
}
