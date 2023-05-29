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
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .toolbar(.visible, for: .navigationBar)
            }
            .environmentObject(vm)
        }
    }
}
