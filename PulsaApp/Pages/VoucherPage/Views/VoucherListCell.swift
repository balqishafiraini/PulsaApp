//
//  VoucherListCell.swift
//  PulsaApp
//
//  Created by Balqis on 20/05/25.
//

import Foundation
import UIKit

class VoucherListCell: UITableViewCell {
    static let identifier = "VoucherListCell"

    var onUseButtonTapped: (() -> Void)?

    private lazy var containerCard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()

    private lazy var voucherImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .systemGray5
        return iv
    }()

    private lazy var newLabel: PaddedLabel = {
        let label = PaddedLabel()
        label.text = "Baru"
        label.backgroundColor = UIColor.white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .red
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    private lazy var expiryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    private lazy var useButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pakai", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemOrange
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.layer.cornerRadius = 6
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupViews()
        useButton.addTarget(self, action: #selector(useButtonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(containerCard)
        containerCard.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 8, paddingRight: 16)

        containerCard.addSubview(voucherImageView)
        containerCard.addSubview(newLabel)
        containerCard.addSubview(nameLabel)
        containerCard.addSubview(expiryLabel)
        containerCard.addSubview(useButton)

        voucherImageView.anchor(top: containerCard.topAnchor, left: containerCard.leftAnchor, right: containerCard.rightAnchor, height: 90)

        newLabel.anchor(top: voucherImageView.topAnchor, left: voucherImageView.leftAnchor, paddingTop: 6)

        nameLabel.anchor(top: voucherImageView.bottomAnchor, left: containerCard.leftAnchor, paddingTop: 8, paddingLeft: 12)

        expiryLabel.anchor(top: nameLabel.bottomAnchor, left: containerCard.leftAnchor, paddingTop: 2, paddingLeft: 12)

        useButton.anchor(bottom: containerCard.bottomAnchor, right: containerCard.rightAnchor, paddingBottom: 12, paddingRight: 12, width: 70, height: 36)
    }

    func configure(with voucher: VoucherItems) {
        voucherImageView.loadImage(from: voucher.imageUrl)
        nameLabel.text = voucher.name

        let regularText = "Berlaku hingga "
        let boldText = voucher.formattedEndDate

        let attributedText = NSMutableAttributedString(
            string: regularText,
            attributes: [.font: UIFont.systemFont(ofSize: 13)]
        )
        let boldAttributedString = NSAttributedString(
            string: boldText,
            attributes: [.font: UIFont.boldSystemFont(ofSize: 13)]
        )
        attributedText.append(boldAttributedString)
        expiryLabel.attributedText = attributedText
    }


    @objc private func useButtonTapped() {
        onUseButtonTapped?()
    }
}
extension VoucherItems {
    var formattedEndDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        if let timeInterval = Double(endDate) {
            let date = Date(timeIntervalSince1970: timeInterval)
            return formatter.string(from: date)
        }
        return "-"
    }
}
