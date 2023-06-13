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
    
    @StateObject var vm:DetailViewModel
    @State private var showFullDescription:Bool = false
    
    private let column:[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing:CGFloat = 30
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initailaizing for detail view \(coin.name) ")
    }
    
    var body: some View {
        ScrollView {
            
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing:20) {
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrad
                    additionalTitle
                    Divider()
                    additionalGrad
                    websiteSection
                }
                .padding()
            }
            
            
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailing
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView {
    
    private var navigationBarTrailing: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            
            CoinImageView(coin: vm.coin)
                .frame(width: 25 , height: 25)
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity , alignment: .leading)
    }
    
    private var descriptionSection:some View {
        ZStack {
            if let coinDescription = vm.coinDescription ,
               !coinDescription.isEmpty {
                VStack(alignment:.leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                    .foregroundColor(Color.theme.secondaryText)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical ,4)
                            
                    }
                    .tint(.blue)
                    

                }
                
            }
        }

    }
    
    private var additionalTitle:some View {
        Text("Additional")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity , alignment: .leading)
    }
    
    private var overviewGrad:some View {
        LazyVGrid(
            columns: column,
            alignment: .leading ,
            spacing: spacing) {
                ForEach(vm.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    private var additionalGrad:some View {
        LazyVGrid(
            columns: column,
            alignment: .leading ,
            spacing: spacing) {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    private var websiteSection:some View {
        VStack(alignment: .leading,spacing: 10) {
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString) {
                Link("Website", destination: url)
            }
            
            if let redditString = vm.redditURL,
               let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
        }
        .tint(.blue)
        .frame(maxWidth: .infinity,alignment:.leading)
        .font(.headline)

    }
}
