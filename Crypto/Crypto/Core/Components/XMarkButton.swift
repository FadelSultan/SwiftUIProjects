//
//  XMarkButton.swift
//  Crypto
//
//  Created by Fadel on 15/11/1444 AH.
//

import SwiftUI

struct XMarkButton: View {
    
    @Binding var isPresented:Bool
    
    var body: some View {
        
        Button {
            isPresented = false
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(Color.theme.accent)
        }

    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton(isPresented: .constant(true))
    }
}
