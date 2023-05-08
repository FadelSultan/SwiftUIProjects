//
//  MultipleSheetBootcamp.swift
//  SwiftUIListThree
//
//  Created by Fadel on 18/10/1444 AH.
//

import SwiftUI

struct RandomModel:Identifiable {
    let id:String = UUID().uuidString
    let title:String
    let backgroundColor:Color
}

struct MultipleSheetBootcamp: View {
    
    @State var selectedModel:RandomModel? = nil
    
    var body: some View {
        ZStack{
            Color.purple
                .ignoresSafeArea()
  
            VStack(spacing:20){
                Button {
                    selectedModel = RandomModel(title: "Screen one".capitalized, backgroundColor: .green)
                } label: {
                    Text("Sheet one".capitalized)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                
                Button {
                    selectedModel = RandomModel(title: "Screen two  ".capitalized, backgroundColor: .pink)
                } label: {
                    Text("Sheet tow".capitalized)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }.sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
            }
            
        }
    }
}

struct MultipleSheetBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetBootcamp()
    }
}


struct NextScreen:View {
    
    let selectedModel:RandomModel
    
    var body: some View {
        ZStack {
            selectedModel.backgroundColor
                .ignoresSafeArea()
            
            Text("\(selectedModel.title)")
        }
    }
    
}
