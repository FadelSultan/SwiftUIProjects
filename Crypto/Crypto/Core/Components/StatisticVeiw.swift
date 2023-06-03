//
//  StatisticVeiw.swift
//  Crypto
//
//  Created by Fadel Sultan on 14/11/1444 AH.
//

import SwiftUI

struct StatisticVeiw: View {
    
    let stat:StatisticModel
    
    var body: some View {
        VStack (alignment:.leading , spacing: 4){
            
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            HStack(spacing:3) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(stat.percentageChange?.asPerentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor(
                (stat.percentageChange ?? 0) >= 0 ?
                Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
            
        }
    }
}

struct StatisticVeiw_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            StatisticVeiw(stat: dev.stat1)
            StatisticVeiw(stat: dev.stat2)
            StatisticVeiw(stat: dev.stat3)
            
        }
        .previewLayout(.sizeThatFits)
    }
}
