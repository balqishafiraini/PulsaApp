//
//  UIViewController+Extension.swift
//  PulsaApp
//
//  Created by Balqis on 16/05/25.
//

import UIKit

extension UIViewController {
    func setupNavigationTitle(_ title: String, showBackButton: Bool = true) {
        self.title = title
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.tintColor = .white 
        navigationItem.backButtonTitle = ""
        
        if showBackButton {
            navigationItem.hidesBackButton = false
        } else {
            navigationItem.hidesBackButton = true
        }
    }
}
