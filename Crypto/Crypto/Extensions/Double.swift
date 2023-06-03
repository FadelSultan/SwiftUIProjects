//
//  Double.swift
//  Crypto
//
//  Created by Fadel Sultan on 06/11/1444 AH.
//

import Foundation


extension Double {
    
    
    /// Convert a Double to a Currency with 2 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// ```
    ///
    private var currencyFormatter2:NumberFormatter {
 
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current // deafult value
//        formatter.currencyCode = "usd" // change currency
//        formatter.currencySymbol = "$" // change currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Convert a Double to a Currency as a String with 2 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// ```
    func asCurrencyWith2Decimal() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    
    
    /// Convert a Double to a Currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// ```
    ///
    private var currencyFormatter6:NumberFormatter {
 
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current // deafult value
//        formatter.currencyCode = "usd" // change currency
//        formatter.currencySymbol = "$" // change currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Convert a Double to a Currency as a String with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    /// ```
    func asCurrencyWith6Decimal() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Convert a Double into string represntation
    /// ```
    /// Convert 12.3456 to "12.34"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    
    /// Convert a Double into string represntation with Percent symbol
    /// ```
    /// Convert 12.3456 to "12.34% "
    /// ```
    func asPerentString() -> String {
        return asNumberString() + "%"
    }
    
    ///Convert a Double to a String with K,M,Bn,Tr abbreviations.
    ///```
    ///Convert 12 to 12.00
    ///Convert 1234 to 1.23K
    ///Convert 123456 to 123.45K
    ///Convert 12345678 to 12.34M
    ///Convert 1234567890 to 1.23Bn
    ///Convert 123456789012 to 123.45Bn
    ///Convert 12345678901234 to 12.34Tr
    ///```
    
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0 ) ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let signFormatted = formatted.asNumberString()
            return "\(sign)\(signFormatted)Tr"
            
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let signFormatted = formatted.asNumberString()
            return "\(sign)\(signFormatted)Bn"
            
        case 1_000_000...:
            let formatted = num / 1_000_000
            let signFormatted = formatted.asNumberString()
            return "\(sign)\(signFormatted)M"
            
        case 1_000...:
            let formatted = num / 1_000
            let signFormatted = formatted.asNumberString()
            return "\(sign)\(signFormatted)K"
            
        case 0...:
            return self.asNumberString()
        default:
            return "\(sign)\(self)"
        }
    }
}
