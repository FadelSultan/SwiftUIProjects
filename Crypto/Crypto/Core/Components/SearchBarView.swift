//
//  SearchBarView.swift
//  Crypto
//
//  Created by Fadel on 12/11/1444 AH.
//

import SwiftUI

struct SearchBarView: View {
    
    
    @State var searchText:String = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.theme.secondaryText)
            
            TextField("Search by name or symbol ...", text: $searchText)
                
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color.theme.background)
                .shadow(radius: 10)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
