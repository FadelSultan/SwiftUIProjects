//
//  ScrollViewReaderBootcamp.swift
//  SwiftUIListThree
//
//  Created by Fadel on 17/10/1444 AH.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    var body: some View {
        
        ScrollViewReader { proxy in
            
            ScrollView {
                Button("Go to index #49") {
                    withAnimation(.spring()) {
                        proxy.scrollTo(49,anchor: .top)
                    }
                }
                
                ForEach(0..<50 , id: \.self) { index in
                    
                    let randomColor:Color = [Color.white,Color.blue,Color.pink , Color.purple , Color.brown ,Color.green].randomElement()!
                    
                    Text("This is index #\(index)")
                        .font(.headline)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .background(randomColor)
                        .cornerRadius(20)
                        .shadow(color: randomColor == .white ? .gray.opacity(0.5) : randomColor.opacity(1),radius: 10)
                        .padding()
                        .id(index)
                }
            }
        }
        
        
        
        
        
    }
}

struct ScrollViewReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBootcamp()
    }
}
