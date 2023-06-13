//
//  String.swift
//  Crypto
//
//  Created by Fadel Sultan on 24/11/1444 AH.
//

import Foundation
extension String {
    var removingHTMLOccurrences:String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "",options: .regularExpression)
    }
}
