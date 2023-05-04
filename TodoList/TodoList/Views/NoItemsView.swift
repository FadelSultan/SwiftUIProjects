//
//  NoItemsView.swift
//  TodoList
//
//  Created by Fadel Sultan on 13/10/1444 AH.
//

import SwiftUI

struct NoItemsView: View {
    
    @State private var isAnimated:Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("There are no items!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Are you a productive person? I think you should click the add button and add a bunch of items to your todo list! 😇")
                
                NavigationLink {
                    
                } label: {
                    Text("Add Your Task 😎".capitalized)
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(isAnimated ? Color.accentColor : Color.red)
                        .cornerRadius(10)
                }

            }
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
            
        }.frame(maxWidth: .infinity , maxHeight: .infinity)
    }
    
    private func addAnimation() {
        guard !isAnimated else {return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                isAnimated.toggle()
            }
        }
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NoItemsView()
                .navigationTitle("Title")
        }
    }
}
