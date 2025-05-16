//
//  CustomSegmentedControl.swift
//  PulsaApp
//
//  Created by Balqis on 16/05/25.
//

import Foundation
import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func segmentedControl(didSelect index: Int)
}

class CustomSegmentedControl: UIView {
    
    private var buttonTitles: [String]
    private var buttons: [UIButton] = []
    private let underlineView = UIView()
    private var selectorLeadingConstraint: NSLayoutConstraint?
    private var underlineWidthConstraint: NSLayoutConstraint?
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    private(set) var selectedIndex: Int = 0

    init(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white
        setupButtons()
        setupUnderline()
    }

    private func setupButtons() {
        buttons = buttonTitles.enumerated().map { index, title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(index == selectedIndex ? .systemOrange : .lightGray, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            return button
        }

        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.addConstraintsToFillView(self)
    }

    private func setupUnderline() {
        underlineView.backgroundColor = .systemOrange
        addSubview(underlineView)
        
        underlineView.anchor(bottom: bottomAnchor, height: 2)
        selectorLeadingConstraint = underlineView.leftAnchor.constraint(equalTo: leftAnchor)
        selectorLeadingConstraint?.isActive = true
        
        underlineWidthConstraint = underlineView.widthAnchor.constraint(equalToConstant: 0)
        underlineWidthConstraint?.isActive = true
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        setSelectedIndex(sender.tag)
        delegate?.segmentedControl(didSelect: sender.tag)
    }

    func setSelectedIndex(_ index: Int, animated: Bool = true) {
        guard index < buttons.count else { return }
        selectedIndex = index
        
        buttons.enumerated().forEach { idx, button in
            button.setTitleColor(idx == index ? .systemOrange : .lightGray, for: .normal)
        }

        let segmentWidth = frame.width / CGFloat(buttons.count)
        selectorLeadingConstraint?.constant = CGFloat(index) * segmentWidth
        underlineWidthConstraint?.constant = segmentWidth
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        } else {
            self.layoutIfNeeded()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let segmentWidth = frame.width / CGFloat(buttons.count)
        selectorLeadingConstraint?.constant = CGFloat(selectedIndex) * segmentWidth
        underlineWidthConstraint?.constant = segmentWidth
    }
}
