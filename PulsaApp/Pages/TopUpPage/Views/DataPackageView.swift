//
//  DataPackageView.swift
//  PulsaApp
//
//  Created by Balqis on 16/05/25.
//

import Foundation
import UIKit

class DataPackageView: UIView {
    lazy var mobileNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Data"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupViews() {
        print("Data Package view coming soon")
    }
}

