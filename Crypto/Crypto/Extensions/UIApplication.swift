//
//  UIApplication.swift
//  Crypto
//
//  Created by Fadel Sultan on 14/11/1444 AH.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
