//
//  DetailView.swift
//  Crypto
//
//  Created by Fadel Sultan on 20/11/1444 AH.
//

import SwiftUI

struct DetailLoadingView:View {
    
    @Binding var coin:CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject var vm:CoinDetailViewModel
    
    private let column:[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing:CGFloat = 30
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
        print("Initailaizing for detail view \(coin.name) ")
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing:20) {
                Text("")
                    .frame(height: 150)
                
                Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: .infinity , alignment: .leading)
                
                Divider()
                
                LazyVGrid(
                    columns: column,
                    alignment: .leading ,
                    spacing: spacing) {
                        ForEach(0..<6) { _ in
                            StatisticView(stat: StatisticModel(title: "Title", value: "Value"))
                        }
                    }
                
                Text("Additional")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: .infinity , alignment: .leading)
                
                Divider()
                
                LazyVGrid(
                    columns: column,
                    alignment: .leading ,
                    spacing: spacing) {
                        ForEach(0..<6) { _ in
                            StatisticView(stat: StatisticModel(title: "Title", value: "Value"))
                        }
                    }
                
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}
