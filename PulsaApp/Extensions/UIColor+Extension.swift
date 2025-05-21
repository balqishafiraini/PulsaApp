//
//  UIColor+Extension.swift
//  PulsaApp
//
//  Created by Balqis on 20/05/25.
//

import Foundation
import UIKit

extension UIColor {
    func darker(by percentage: CGFloat = 20.0) -> UIColor {
        var r: CGFloat=0, g: CGFloat=0, b: CGFloat=0, a: CGFloat=0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: max(r - percentage/100, 0.0),
                           green: max(g - percentage/100, 0.0),
                           blue: max(b - percentage/100, 0.0),
                           alpha: a)
        }
        return self
    }
}
