//
//  HomeStatsView.swift
//  Crypto
//
//  Created by Fadel Sultan on 14/11/1444 AH.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm:HomeViewModel
    @Binding var showProtfolio:Bool
    
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticVeiw(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showProtfolio ? .trailing : .leading)
        
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showProtfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
