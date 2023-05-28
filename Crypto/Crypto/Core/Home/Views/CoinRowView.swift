//
//  CoinRowView.swift
//  Crypto
//
//  Created by Fadel Sultan on 06/11/1444 AH.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin:CoinModel
    let isShoweHoldingsColumn:Bool
    var body: some View {
        HStack(spacing:0) {
            leftColumn
            Spacer()
            
            if isShoweHoldingsColumn {
                centerColumn
            }
            
            columnRight
        }
        
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, isShoweHoldingsColumn: true)
    }
} 


extension CoinRowView {
    
    private var leftColumn : some View {
        HStack(spacing:0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(width: 30)
            
            Circle()
                .frame(width: 30 , height: 30)
            
            Text(coin.symbol?.uppercased() ?? "")
                .font(.headline)
                .padding(.leading , 6)
                .foregroundColor(Color.theme.accent)
        }
        .font(.subheadline)

    }
    
    private var centerColumn:some View {
        VStack (alignment:.trailing) {
            Text(coin.currentsHoldingsValue.asCurrencyWith2Decimal())
                .bold()
            
            Text((coin.currentHoldings ?? 0).asNumberString())
            
        }
        .foregroundColor(Color.theme.accent)
    }
    
    private var columnRight:some View {
        VStack (alignment:.trailing){
            Text((coin.currentPrice ?? 0).asCurrencyWith6Decimal())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text((coin.priceChangePercentage24H ?? 0).asPerentString())
                .foregroundColor(
                    coin.priceChangePercentage24H ?? 0 >= 0 ?
                    Color.theme.green :
                    Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
    }
}
