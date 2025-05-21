//
//  TransactionSuccessView.swift
//  PulsaApp
//
//  Created by Balqis on 20/05/25.
//

import Foundation
import UIKit

class TransactionSuccessView: UIView {
        
    private let detailPesananContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    private let detailPembayaranContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    private let contactContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 8
        return view
    }()
        
    private let detailPesananHeaderLabel: PaddedLabel = {
        let label = PaddedLabel()
        label.text = "Detail Pesanan"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.backgroundColor = UIColor.systemGray5 
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let detailPembayaranHeaderLabel: PaddedLabel = {
        let label = PaddedLabel()
        label.text = "Detail Pembayaran"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.backgroundColor = UIColor.systemGray5
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
        
    private let dividerOrder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        return view
    }()
    
    private let dividerPayment: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        return view
    }()
        
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "provider")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        return imageView
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    private let statusTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Status"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let statusValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.systemGreen
        label.textAlignment = .right
        return label
    }()
    
    private let orderIdTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Order ID"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let orderIdValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    private let itemListStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private let subtotalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Subtotal"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private let subtotalValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.textAlignment = .right
        return label
    }()
    
    private let payInTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Bayar dalam 30 hari"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .systemOrange
        return label
    }()
    
    private let payInValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .systemOrange
        label.textAlignment = .right
        return label
    }()
    
    private let contactLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        label.numberOfLines = 0
        label.text = "Jika kamu punya kendala terkait transaksimu, pastikan untuk menghubungi customer service kami di 0807-1-573-348 atau support@kredivo.com."
        return label
    }()
    
    let okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Oke", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemOrange
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(detailPesananContainer)
        scrollView.addSubview(detailPembayaranContainer)
        scrollView.addSubview(contactContainer)
        addSubview(okButton)

        detailPesananContainer.addSubview(detailPesananHeaderLabel)
        detailPesananContainer.addSubview(logoImageView)
        detailPesananContainer.addSubview(phoneNumberLabel)
        detailPesananContainer.addSubview(dividerOrder)
        detailPesananContainer.addSubview(statusTitleLabel)
        detailPesananContainer.addSubview(statusValueLabel)
        detailPesananContainer.addSubview(orderIdTitleLabel)
        detailPesananContainer.addSubview(orderIdValueLabel)

        detailPembayaranContainer.addSubview(detailPembayaranHeaderLabel)
        detailPembayaranContainer.addSubview(itemListStackView)
        detailPembayaranContainer.addSubview(dividerPayment)
        detailPembayaranContainer.addSubview(subtotalTitleLabel)
        detailPembayaranContainer.addSubview(subtotalValueLabel)
        detailPembayaranContainer.addSubview(payInTitleLabel)
        detailPembayaranContainer.addSubview(payInValueLabel)

        contactContainer.addSubview(contactLabel)

        scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: okButton.topAnchor, right: rightAnchor)
        
        detailPesananContainer.anchor(top: scrollView.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        detailPesananHeaderLabel.anchor(top: detailPesananContainer.topAnchor, left: detailPesananContainer.leftAnchor, right: detailPesananContainer.rightAnchor, height: 50)
        logoImageView.anchor(top: detailPesananHeaderLabel.bottomAnchor, left: detailPesananContainer.leftAnchor, paddingTop: 16, paddingLeft: 16, width: 40, height: 40)
        phoneNumberLabel.centerY(inView: logoImageView)
        phoneNumberLabel.anchor(left: logoImageView.rightAnchor, right: detailPesananContainer.rightAnchor, paddingLeft: 12, paddingRight: 16)
        dividerOrder.anchor(top: logoImageView.bottomAnchor, left: detailPesananContainer.leftAnchor, right: detailPesananContainer.rightAnchor, paddingTop: 16, height: 1)
        statusTitleLabel.anchor(top: dividerOrder.bottomAnchor, left: detailPesananContainer.leftAnchor, paddingTop: 16, paddingLeft: 16)
        statusValueLabel.centerYAnchor.constraint(equalTo: statusTitleLabel.centerYAnchor).isActive = true
        statusValueLabel.anchor(right: detailPesananContainer.rightAnchor, paddingRight: 16)
        orderIdTitleLabel.anchor(top: statusTitleLabel.bottomAnchor, left: detailPesananContainer.leftAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 16)
        orderIdValueLabel.centerYAnchor.constraint(equalTo: orderIdTitleLabel.centerYAnchor).isActive = true
        orderIdValueLabel.anchor(right: detailPesananContainer.rightAnchor, paddingRight: 16)
        detailPesananContainer.bottomAnchor.constraint(equalTo: orderIdTitleLabel.bottomAnchor, constant: 16).isActive = true
        
        detailPembayaranContainer.anchor(top: detailPesananContainer.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        detailPembayaranHeaderLabel.anchor(top: detailPembayaranContainer.topAnchor, left: detailPembayaranContainer.leftAnchor, right: detailPembayaranContainer.rightAnchor, height: 50)
        itemListStackView.anchor(top: detailPembayaranHeaderLabel.bottomAnchor, left: detailPembayaranContainer.leftAnchor, right: detailPembayaranContainer.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        subtotalTitleLabel.anchor(top: itemListStackView.bottomAnchor, left: detailPembayaranContainer.leftAnchor, paddingTop: 10, paddingLeft: 16)
        dividerPayment.anchor(top: subtotalTitleLabel.bottomAnchor, left: detailPembayaranContainer.leftAnchor, right: detailPembayaranContainer.rightAnchor, paddingTop: 16, height: 1)
        subtotalValueLabel.centerYAnchor.constraint(equalTo: subtotalTitleLabel.centerYAnchor).isActive = true
        subtotalValueLabel.anchor(right: detailPembayaranContainer.rightAnchor, paddingRight: 16)
        payInTitleLabel.anchor(top: dividerPayment.bottomAnchor, left: detailPembayaranContainer.leftAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 16)
        payInValueLabel.centerYAnchor.constraint(equalTo: payInTitleLabel.centerYAnchor).isActive = true
        payInValueLabel.anchor(right: detailPembayaranContainer.rightAnchor, paddingRight: 16)
        detailPembayaranContainer.bottomAnchor.constraint(equalTo: payInTitleLabel.bottomAnchor, constant: 16).isActive = true

        contactContainer.anchor(top: detailPembayaranContainer.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        contactLabel.anchor(top: contactContainer.topAnchor, left: contactContainer.leftAnchor, bottom: contactContainer.bottomAnchor, right: contactContainer.rightAnchor, paddingTop: 12, paddingLeft: 16, paddingBottom: 12, paddingRight: 16)

        okButton.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 60)
    }

    func configure(with response: TransactionStatusResponse) {
        if let firstItem = response.transactionContext.itemList.first {
            phoneNumberLabel.text = firstItem.name
        }
        
        statusValueLabel.text = response.status == "OK" ? "Transaksi Berhasil" : "Transaksi Gagal"
        orderIdValueLabel.text = response.transactionContext.orderId
        
        itemListStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for item in response.transactionContext.itemList {
            let itemRow = createItemRow(name: item.name, price: item.totalAmount)
            itemListStackView.addArrangedSubview(itemRow)
        }
        
        let subtotalPrice = response.transactionContext.amount
        subtotalValueLabel.text = PriceFormatter.format(from: subtotalPrice)
        payInValueLabel.text = PriceFormatter.format(from: subtotalPrice)
    }
    
    private func createItemRow(name: String, price: String) -> UIView {
        let container = UIView()
        
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = .darkGray
        nameLabel.text = name
        nameLabel.numberOfLines = 2
        
        let priceLabel = UILabel()
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = .darkGray
        priceLabel.textAlignment = .right
        let jsonString = String(price)
        priceLabel.text = PriceFormatter.format(from: jsonString)
        
        container.addSubview(nameLabel)
        container.addSubview(priceLabel)
        
        nameLabel.anchor(top: container.topAnchor, left: container.leftAnchor, bottom: container.bottomAnchor, right: priceLabel.leftAnchor, paddingRight: 8)
        priceLabel.anchor(top: container.topAnchor, bottom: container.bottomAnchor, right: container.rightAnchor, paddingRight: 0)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        priceLabel.setContentHuggingPriority(.required, for: .horizontal)
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return container
    }
}
