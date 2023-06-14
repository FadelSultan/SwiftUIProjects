//
//  SettingsView.swift
//  Crypto
//
//  Created by Fadel Sultan on 25/11/1444 AH.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isCloseView:Bool
    
    private let defaultURL = URL(string: "https://www.google.com")!
    private let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    private let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    private let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    private let personalURL = URL(string: "https://www.fadeldev.com")!
    
    var body: some View {
        NavigationStack {
            List {
                swiftFulThinkingSection
                coinGeckoSection
                developerSection
                applicationSection
            }
            .font(.headline)
            .tint(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem (placement:.navigationBarLeading){
                    XMarkButton(isPresented: $isCloseView)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isCloseView: .constant(false))
    }
}


extension SettingsView {
    
    private var swiftFulThinkingSection:some View {
        Section {
            VStack(alignment:.leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text("This app was made by following a @SwiftfulThinking course on Youtube. It uses MVVM architecture ,Combine , and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Subscribe on Youtube 🥳", destination: youtubeURL)
            Link("Support his coffee addiction ☕️", destination: coffeeURL)
        } header: {
            Text("SWIFTFUL THINKING")
        }
    }
    
    private var coinGeckoSection:some View {
        Section {
            VStack(alignment:.leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit CoinGecko 🦎", destination: coinGeckoURL)
            
        } header: {
            Text("CoinGecko".uppercased())
        }
    }
    
    private var developerSection:some View {
        Section {
            HStack(alignment:.center) {
                Image("FadelSultan")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("This app was developed by Fadel Sultan. I use a play list on Youtube to learn SwiftUI, It's perfect channel to learn SwiftUI , I use a lot of things in this project, MVVM architecture, Combine, CoreData, and the best thing is improve my concept yo write clean code 😇. ")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit Website 🤙", destination: personalURL )
            
        } header: {
            Text("Developer".uppercased())
        }
    }
    
    private var applicationSection:some View {
        Section {
            Link("🅣 Terms of Service ", destination: defaultURL)
            Link("🅟 Privacy Policy", destination: defaultURL)
            Link("🅒 Company Website", destination: defaultURL)
            Link("🅛 Learn More", destination: defaultURL)
            
        } header: {
            Text("Developer".uppercased())
        }
    }
    
    

}
