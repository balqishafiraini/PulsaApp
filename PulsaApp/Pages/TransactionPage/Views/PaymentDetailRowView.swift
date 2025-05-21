//
//  PaymentDetailRowView.swift
//  PulsaApp
//
//  Created by Balqis on 20/05/25.
//

import Foundation
import UIKit

class PaymentDetailRowView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .right
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingLeft: 16)
        valueLabel.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor, paddingRight: 16)
        
        titleLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.7).isActive = true
    }

    func configure(title: String, value: String, valueColor: UIColor = .darkGray) {
        titleLabel.text = title
        valueLabel.text = value
        valueLabel.textColor = valueColor
    }
}

