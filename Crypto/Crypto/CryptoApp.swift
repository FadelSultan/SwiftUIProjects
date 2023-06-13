//
//  CryptoApp.swift
//  Crypto
//
//  Created by Fadel on 03/11/1444 AH.
//

import SwiftUI

@main
struct CryptoApp: App {
    
    
    @StateObject private var vm = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor:UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.visible, for: .navigationBar)
            }
            .environmentObject(vm)
        }
    }
}
