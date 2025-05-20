//
//  TopUpPageView.swift
//  PulsaApp
//
//  Created by Balqis on 16/05/25.
//

import Foundation
import UIKit

protocol TopUpPageViewDelegate: AnyObject {
    func didSelectSegment(at index: Int)
}

class TopUpPageView: UIView {
    
    weak var delegate: TopUpPageViewDelegate?
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var customSegmentedControl: CustomSegmentedControlView = {
        let control = CustomSegmentedControlView(buttonTitles: ["Pulsa", "Data Package"])
        return control
    }()
    
    lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        addSubview(stackView)
        stackView.addArrangedSubview(customSegmentedControl)
        stackView.addArrangedSubview(containerView)
        stackView.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor)
        
        customSegmentedControl.anchor(height: 50)
        customSegmentedControl.delegate = self
        
    }
}

extension TopUpPageView: CustomSegmentedControlDelegate {
    func segmentedControl(didSelect index: Int) {
        delegate?.didSelectSegment(at: index)
    }
}
