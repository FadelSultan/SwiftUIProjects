//
//  Color.swift
//  Crypto
//
//  Created by Fadel on 03/11/1444 AH.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorThem()
    static let lunch = LunchThame()
}

struct ColorThem {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let red = Color("RedColor")
    let green = Color("GreenColor")
    let secondaryText = Color("SecondaryTextColor")
    
}

struct LunchThame {
    let background = Color("LunchBackground")
    let accent = Color("LunchAccentColor")
}
