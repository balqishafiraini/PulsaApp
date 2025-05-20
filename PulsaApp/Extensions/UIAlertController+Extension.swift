//
//  UIAlertController+Extension.swift
//  PulsaApp
//
//  Created by Balqis on 19/05/25.
//

import Foundation
import UIKit
import UIKit

class AlertHelper {
    
    class func showAlert(title: String, message: String, from viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true)
    }
    
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        AlertHelper.showAlert(title: title, message: message, from: self)
    }
}
