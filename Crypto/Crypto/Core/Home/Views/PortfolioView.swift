//
//  PortfolioView.swift
//  Crypto
//
//  Created by Fadel on 15/11/1444 AH.
//

import SwiftUI

struct PortfolioView: View {
    
    @Binding var isPresented:Bool
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack(alignment: .leading , spacing: 0) {
                    Text("Portfolio View")
                }
            }
            
            
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(isPresented: $isPresented)
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(isPresented: .constant(false))
    }
}
