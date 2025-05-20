//
//  PriceFormatter.swift
//  PulsaApp
//
//  Created by Balqis on 16/05/25.
//

import Foundation

struct PriceFormatter {
    static func format(from string: String) -> String {
        // Hilangkan titik desimal jika ada (contoh: "7.500" → "7500")
        let sanitized = string.replacingOccurrences(of: ".", with: "")
        let value = Double(sanitized) ?? 0
        return format(price: value)
    }

    static func format(price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp "
        formatter.currencyGroupingSeparator = "."
        formatter.currencyDecimalSeparator = ","
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "id_ID")
        return formatter.string(from: NSNumber(value: price)) ?? "Rp \(Int(price))"
    }
}


extension Int {
    var formattedWithSeparator: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

extension Double {
    var formattedWithSeparator: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        numberFormatter.decimalSeparator = ","
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
