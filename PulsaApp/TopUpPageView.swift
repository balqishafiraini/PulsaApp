//
//  TopUpPageView.swift
//  PulsaApp
//
//  Created by Balqis on 16/05/25.
//

import Foundation
import UIKit

class TopUpPageView: UIView {
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var customSegmentedControl: CustomSegmentedControl = {
        let control = CustomSegmentedControl(buttonTitles: ["Pulsa", "Data Package"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
//    private let pulsaView = PulsaView()
//    private let dataPackageView = DataPackageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        addSubview(headerView)

        headerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: UIScreen.main.bounds.height/8.5)
        
        addSubview(stackView)
        stackView.addArrangedSubview(customSegmentedControl)
        stackView.addArrangedSubview(containerView)
        stackView.anchor(top: headerView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        customSegmentedControl.anchor(height: 50)
    }
}
