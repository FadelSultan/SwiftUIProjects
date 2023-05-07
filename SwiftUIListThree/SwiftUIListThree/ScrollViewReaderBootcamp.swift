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
                
                ForEach(0..<50, id: \.self) { index in
                    
                    Text("This is index #\(index)")
                        .font(.headline)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: .gray.opacity(0.5),radius: 10)
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
