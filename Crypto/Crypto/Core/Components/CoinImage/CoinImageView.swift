//
//  CoinImageView.swift
//  Crypto
//
//  Created by Fadel on 11/11/1444 AH.
//

import SwiftUI
import Combine



struct CoinImageView: View {
    
    @StateObject var vm:CoinImageViewModel
    
    init(coin:CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        
        if let image = vm.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }else if vm.isLoading {
            ProgressView()
        }else {
            Image(systemName: "questionmark")
                .foregroundColor(Color.theme.secondaryText)
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
