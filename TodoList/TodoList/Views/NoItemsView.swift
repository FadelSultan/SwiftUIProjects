//
//  NoItemsView.swift
//  TodoList
//
//  Created by Fadel Sultan on 13/10/1444 AH.
//

import SwiftUI

struct NoItemsView: View {
    
    @State private var isAnimated:Bool = false
    private let secondaryAccentColor:Color = Color("secondaryAccentColor")
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("There are no items!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Are you a productive person? I think you should click the add button and add a bunch of items to your todo list! 😇")
                    .padding(.bottom , 40)
                
                NavigationLink {
                    AddView()
                } label: {
                    Text("Add Your Task 😎".capitalized)
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(isAnimated ? secondaryAccentColor : Color.accentColor)
                        .cornerRadius(10)
                }
                .padding(.horizontal , isAnimated ? 30 : 50)
                .shadow(
                    color: isAnimated ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                    radius: isAnimated ? 30 : 10,
                    y: isAnimated ? 50 : 30
                )
                .scaleEffect(isAnimated ? 1.1 : 1.0)
                .offset(y: isAnimated ? -7 : 0)

            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: 400)
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
