//
//  String+Extension.swift
//  PulsaApp
//
//  Created by Balqis on 21/05/25.
//

import Foundation

extension String {
    func formattedPhoneNumber(shouldSlice: Bool = true, convertTo62: Bool = true) -> String {
        guard !self.isEmpty else {
            return "No phone number"
        }
        
        var formattedNumber = self
        
        if convertTo62 {
            if formattedNumber.hasPrefix("0") {
                formattedNumber.removeFirst()
                formattedNumber = "62" + formattedNumber
            } else if !formattedNumber.hasPrefix("62") {
                formattedNumber = "62" + formattedNumber
            }
            
            formattedNumber.insert("-", at: formattedNumber.index(formattedNumber.startIndex, offsetBy: 2))
        }
        
        if shouldSlice {
            let sliceStartIndex = formattedNumber.firstIndex(of: "-").map {
                formattedNumber.index(after: $0)
            } ?? formattedNumber.startIndex
            
            var currentIndex = formattedNumber.distance(from: formattedNumber.startIndex, to: sliceStartIndex)
            
            while currentIndex + 4 < formattedNumber.count {
                currentIndex += 4
                if currentIndex < formattedNumber.count {
                    formattedNumber.insert(" ", at: formattedNumber.index(formattedNumber.startIndex, offsetBy: currentIndex))
                    currentIndex += 1
                }
            }
        }
        
        return formattedNumber
    }
}
