//
//  String+Extension.swift
//  PulsaApp
//
//  Created by Balqis on 20/05/25.
//

import Foundation

extension String {
    func formatPhoneNumberForDisplay() -> String {
        if self.isEmpty {
            return "No phone number"
        }

        var formattedNumber = self

        if formattedNumber.hasPrefix("0") {
            formattedNumber.removeFirst()
            formattedNumber = "62" + formattedNumber
        } else if !formattedNumber.hasPrefix("62") {
            formattedNumber = "62" + formattedNumber
        }

        if formattedNumber.count > 4 {
            formattedNumber.insert(" ", at: formattedNumber.index(formattedNumber.startIndex, offsetBy: 4))
        }
        if formattedNumber.count > 9 {
            let secondSpaceIndex = formattedNumber.index(formattedNumber.startIndex, offsetBy: 9)
            if secondSpaceIndex < formattedNumber.endIndex {
                formattedNumber.insert(" ", at: secondSpaceIndex)
            }
        }

        return formattedNumber
    }
}
