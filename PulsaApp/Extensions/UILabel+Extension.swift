//
//  UILabel+Extension.swift
//  PulsaApp
//
//  Created by Balqis on 20/05/25.
//

import Foundation
import UIKit

class PaddedLabel: UILabel {
    var textInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + textInsets.left + textInsets.right,
                      height: size.height + textInsets.top + textInsets.bottom)
    }
}
