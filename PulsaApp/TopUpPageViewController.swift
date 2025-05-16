//
//  TopUpPageViewController.swift
//  PulsaApp
//
//  Created by Balqis on 16/05/25.
//

import Foundation
import UIKit

class TopUpPageViewController: UIViewController {
    
    lazy var topUpPageView = TopUpPageView()
    
    override func loadView() {
        view = topUpPageView
        setupNavigationTitle("Top Up")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UIViewController {
    func setupNavigationTitle(_ title: String) {
        self.title = title
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
        ]
    }
}
