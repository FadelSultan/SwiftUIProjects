//
//  SearchBarView.swift
//  Crypto
//
//  Created by Fadel on 12/11/1444 AH.
//

import SwiftUI

struct SearchBarView: View {
    
    
    @Binding var searchText:String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.theme.secondaryText)
            
            TextField("Search by name or symbol ...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .autocorrectionDisabled()
                .overlay(alignment:.trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                }
                
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
