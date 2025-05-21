//
//  TransactionPageView.swift
//  PulsaApp
//
//  Created by Balqis on 17/05/25.
//

import Foundation
import UIKit

protocol TransactionPageViewDelegate: AnyObject {
    func transactionPageViewDidTapVoucher(_ view: TransactionPageView)
    func transactionPageViewDidRequestPayment(for productCode: String, phoneNumber: String, pin: String)
    func transactionPageViewDidEncounterPinError(message: String)
    func transactionPageViewDidRemoveVoucher(_ view: TransactionPageView)
}

class TransactionPageView: UIView {
    
    weak var delegate: TransactionPageViewDelegate?
    
    var selectedProduct: ProductItems? {
        didSet {
            updateProductDetails()
        }
    }
    
    var phoneNumber: String? {
        didSet {
            updateProductDetails()
        }
    }
    
    var appliedVoucher: VoucherItems? {
        didSet {
            updateProductDetails()
            updateVoucherDisplay()
        }
    }
    
    private var discountAmount: Double = 0.0
    private var paymentDueInDays: Int = 30
    
    private lazy var headerInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private let operatorLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "provider")
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        return imageView
    }()
    
    private lazy var phoneNumberDisplayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var paymentDetailsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var paymentDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Rincian Pembayaran"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let pulsaNominalRow = PaymentDetailRowView()
    private let diskonTambahanRow = PaymentDetailRowView()
    private let subtotalRow = PaymentDetailRowView()
    private let bayarDalamRow = PaymentDetailRowView()
    
    private lazy var sectionVoucherContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var voucherContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var voucherSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Voucher"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var voucherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "ticket.fill")
        imageView.tintColor = .orange
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var voucherLabel: UILabel = {
        let label = UILabel()
        label.text = "Gunakan Voucher"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var voucherButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Lihat", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(voucherButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var activeVoucherContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.15)
        view.layer.cornerRadius = 8
        view.isHidden = true
        return view
    }()
    
    private lazy var activeVoucherCheckmark: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var activeVoucherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.systemGreen.darker()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var activeVoucherRemoveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("×", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.setTitleColor(.systemGreen, for: .normal)
        button.addTarget(self, action: #selector(removeVoucherTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var voucherNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var voucherChangeButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(voucherButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var applyVoucherView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    
    private lazy var applyVoucherIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "ticket.fill"))
        iv.tintColor = .orange
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var applyVoucherLabel: UILabel = {
        let label = UILabel()
        label.text = "Gunakan Voucher"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var applyVoucherButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Lihat", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(voucherButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var pinKredivoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var pinKredivoLabel: UILabel = {
        let label = UILabel()
        label.text = "PIN Kredivo"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var pinTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "PIN"
        textField.isSecureTextEntry = true
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var showPinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(togglePinVisibility), for: .touchUpInside)
        return button
    }()
    
    private lazy var pinErrorMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemRed
        label.numberOfLines = 1
        label.isHidden = true
        return label
    }()
    
    private lazy var termsAndConditionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        let attributedString = NSMutableAttributedString(string: "Dengan melanjutkan saya setuju dengan ")
        attributedString.append(NSAttributedString(string: "Perjanjian Pinjaman Kredivo.", attributes: [.foregroundColor: UIColor.systemBlue]))
        label.attributedText = attributedString
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndConditionsTapped))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Bayar", for: .normal)
        button.backgroundColor = UIColor.systemOrange
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupPaymentDetailRows()
        updateVoucherDisplay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateVoucherDisplay() {
        if let voucher = appliedVoucher {
            voucherContainerView.isHidden = true
            activeVoucherContainerView.isHidden = false
            
            activeVoucherLabel.text = "\(voucher.name)\nYeay! Kamu mendapatkan promo cicilan 0%"
        } else {
            voucherContainerView.isHidden = false
            activeVoucherContainerView.isHidden = true
            
            voucherLabel.text = "Gunakan Voucher"
            voucherButton.setTitle("Lihat", for: .normal)
        }
    }
    
    private func setupViews() {
        backgroundColor = .systemGray5
        
        addSubview(headerInfoView)
        headerInfoView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, height: 80)
        
        headerInfoView.addSubview(operatorLogoImageView)
        operatorLogoImageView.anchor(left: headerInfoView.leftAnchor, paddingLeft: 16, width: 40, height: 40)
        operatorLogoImageView.centerY(inView: headerInfoView)
        
        headerInfoView.addSubview(phoneNumberDisplayLabel)
        phoneNumberDisplayLabel.anchor(left: operatorLogoImageView.rightAnchor, paddingLeft: 12)
        phoneNumberDisplayLabel.centerY(inView: headerInfoView)
        
        addSubview(paymentDetailsContainerView)
        paymentDetailsContainerView.anchor(top: headerInfoView.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                           paddingTop: 20)
        
        paymentDetailsContainerView.addSubview(paymentDetailsLabel)
        paymentDetailsLabel.anchor(top: paymentDetailsContainerView.topAnchor, left: paymentDetailsContainerView.leftAnchor,
                                   paddingTop: 16, paddingLeft: 16)
        
        paymentDetailsContainerView.addSubview(detailsStackView)
        detailsStackView.anchor(top: paymentDetailsLabel.bottomAnchor, left: paymentDetailsContainerView.leftAnchor,
                                bottom: paymentDetailsContainerView.bottomAnchor, right: paymentDetailsContainerView.rightAnchor,
                                paddingTop: 10, paddingBottom: 16)
        
        addSubview(sectionVoucherContainerView)
        sectionVoucherContainerView.anchor(top: paymentDetailsContainerView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20)
        
        sectionVoucherContainerView.addSubview(voucherSectionLabel)
        voucherSectionLabel.anchor(top: sectionVoucherContainerView.topAnchor, left: sectionVoucherContainerView.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        sectionVoucherContainerView.addSubview(voucherContainerView)
        voucherContainerView.anchor(top: voucherSectionLabel.bottomAnchor, left: sectionVoucherContainerView.leftAnchor,
                                    right: sectionVoucherContainerView.rightAnchor,
                                    paddingTop: 10, paddingLeft: 16, paddingRight: 16, height: 60)
        
        let voucherContainerBottomConstraint = voucherContainerView.bottomAnchor.constraint(
            equalTo: sectionVoucherContainerView.bottomAnchor, constant: -16)
        voucherContainerBottomConstraint.isActive = true
        voucherContainerBottomConstraint.priority = UILayoutPriority(999)
        
        voucherContainerView.addSubview(voucherIcon)
        voucherContainerView.addSubview(voucherLabel)
        voucherContainerView.addSubview(voucherButton)
        
        voucherIcon.anchor(left: voucherContainerView.leftAnchor, paddingLeft: 16, width: 24, height: 24)
        voucherIcon.centerY(inView: voucherContainerView)
        
        voucherLabel.anchor(left: voucherIcon.rightAnchor, paddingLeft: 8)
        voucherLabel.centerY(inView: voucherContainerView)
        
        voucherButton.anchor(right: voucherContainerView.rightAnchor, paddingRight: 16, width: 60)
        voucherButton.centerY(inView: voucherContainerView)
        
        sectionVoucherContainerView.addSubview(activeVoucherContainerView)
        activeVoucherContainerView.anchor(top: voucherSectionLabel.bottomAnchor, left: sectionVoucherContainerView.leftAnchor,  right: sectionVoucherContainerView.rightAnchor, paddingTop: 10, paddingLeft: 16, paddingRight: 16, height: 80)
        
        let activeVoucherBottomConstraint = activeVoucherContainerView.bottomAnchor.constraint(
            equalTo: sectionVoucherContainerView.bottomAnchor, constant: -16)
        activeVoucherBottomConstraint.isActive = true
        
        activeVoucherContainerView.addSubview(activeVoucherCheckmark)
        activeVoucherContainerView.addSubview(activeVoucherLabel)
        activeVoucherContainerView.addSubview(activeVoucherRemoveButton)
        
        activeVoucherCheckmark.anchor(left: activeVoucherContainerView.leftAnchor, paddingLeft: 12, width: 24, height: 24)
        activeVoucherCheckmark.centerY(inView: activeVoucherContainerView)
        
        activeVoucherLabel.anchor(left: activeVoucherCheckmark.rightAnchor, right: activeVoucherRemoveButton.leftAnchor, paddingLeft: 8, paddingRight: 8)
        activeVoucherLabel.centerY(inView: activeVoucherContainerView)
        
        activeVoucherRemoveButton.anchor(right: activeVoucherContainerView.rightAnchor, paddingRight: 12, width: 30, height: 30)
        activeVoucherRemoveButton.centerY(inView: activeVoucherContainerView)
        
        activeVoucherContainerView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        activeVoucherContainerView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        addSubview(pinKredivoContainerView)
        pinKredivoContainerView.anchor(top: sectionVoucherContainerView.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                       paddingTop: 20)
        
        pinKredivoContainerView.addSubview(pinKredivoLabel)
        pinKredivoLabel.anchor(top: pinKredivoContainerView.topAnchor, left: pinKredivoContainerView.leftAnchor,
                               paddingTop: 16, paddingLeft: 16)
        
        pinKredivoContainerView.addSubview(pinTextField)
        pinTextField.anchor(top: pinKredivoLabel.bottomAnchor, left: pinKredivoContainerView.leftAnchor,
                            right: pinKredivoContainerView.rightAnchor, paddingTop: 10,
                            paddingLeft: 16, paddingRight: 16, height: 44)
        
        pinTextField.addSubview(showPinButton)
        showPinButton.anchor(right: pinTextField.rightAnchor, paddingRight: 12, width: 30, height: 24)
        showPinButton.centerY(inView: pinTextField)
        
        pinKredivoContainerView.addSubview(pinErrorMessageLabel)
        pinErrorMessageLabel.anchor(top: pinTextField.bottomAnchor, left: pinKredivoContainerView.leftAnchor,
                                    right: pinKredivoContainerView.rightAnchor, paddingTop: 4,
                                    paddingLeft: 16, paddingRight: 16)
        
        pinKredivoContainerView.addSubview(termsAndConditionsLabel)
        termsAndConditionsLabel.anchor(top: pinErrorMessageLabel.bottomAnchor, left: pinKredivoContainerView.leftAnchor,
                                       bottom: pinKredivoContainerView.bottomAnchor, right: pinKredivoContainerView.rightAnchor,
                                       paddingTop: 10, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        addSubview(payButton)
        payButton.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 60)
    }
    
    private func setupPaymentDetailRows() {
        pulsaNominalRow.configure(title: "Pulsa", value: "Rp0")
        detailsStackView.addArrangedSubview(pulsaNominalRow)
        
        diskonTambahanRow.configure(title: "Diskon Tambahan", value: "-Rp0")
        detailsStackView.addArrangedSubview(diskonTambahanRow)
        
        subtotalRow.configure(title: "Subtotal", value: "Rp0")
        detailsStackView.addArrangedSubview(subtotalRow)
        
        bayarDalamRow.configure(title: "Bayar dalam \(paymentDueInDays) hari", value: "Rp0", valueColor: .orange)
        detailsStackView.addArrangedSubview(bayarDalamRow)
    }
    
    
    func updateProductDetails() {
        guard let product = selectedProduct, let number = phoneNumber else { return }
        
        phoneNumberDisplayLabel.text = formatPhoneNumberForDisplay(number)
        
        let formattedPhoneNumber = formatPhoneNumberForDisplay(number)
        pulsaNominalRow.configure(title: "\(product.provider) \(product.formattedPrice) (+\(formattedPhoneNumber))",
                                  value: product.formattedPrice)
        
        var currentDiscount: Double = 0.0
        if let voucher = appliedVoucher {
            if voucher.percentage > 0 {
                currentDiscount = product.price * (Double(voucher.percentage) / 100.0)
                if currentDiscount > voucher.maxDiscount && voucher.maxDiscount > 0 {
                    currentDiscount = voucher.maxDiscount
                }
            } else if voucher.number > 0 {
                currentDiscount = Double(voucher.number)
                if currentDiscount > voucher.maxDiscount && voucher.maxDiscount > 0 {
                    currentDiscount = voucher.maxDiscount
                }
            }
        }
        discountAmount = currentDiscount
        diskonTambahanRow.configure(title: "Diskon Tambahan", value: "-Rp\(discountAmount.formattedWithSeparator)")
        
        let subtotal = product.price - discountAmount
        subtotalRow.configure(title: "Subtotal", value: PriceFormatter.format(price: subtotal))
        bayarDalamRow.configure(title: "Bayar dalam \(paymentDueInDays) hari",
                                value: PriceFormatter.format(price: subtotal),
                                valueColor: .orange)
    }
    
    private func formatPhoneNumberForDisplay(_ number: String) -> String {
        if number.isEmpty {
            return "No phone number"
        }
        
        var formattedNumber = number
        
        if formattedNumber.hasPrefix("0") {
            formattedNumber.removeFirst()
            formattedNumber = "62" + formattedNumber
        } else if !formattedNumber.hasPrefix("62") {
            formattedNumber = "62" + formattedNumber
        }
        
        if formattedNumber.count > 4 {
            formattedNumber.insert(" ", at: formattedNumber.index(formattedNumber.startIndex, offsetBy: 4))
        }
        if formattedNumber.count > 9 {
            let secondSpaceIndex = formattedNumber.index(formattedNumber.startIndex, offsetBy: 9)
            if secondSpaceIndex < formattedNumber.endIndex {
                formattedNumber.insert(" ", at: secondSpaceIndex)
            }
        }
        
        return formattedNumber
    }
    
    
    @objc private func voucherButtonTapped() {
        print("Voucher button tapped! Notifying delegate.")
        delegate?.transactionPageViewDidTapVoucher(self)
    }
    
    @objc private func removeVoucherTapped() {
        print("Remove voucher tapped!")
        appliedVoucher = nil
        delegate?.transactionPageViewDidRemoveVoucher(self)
    }
    
    @objc private func togglePinVisibility() {
        pinTextField.isSecureTextEntry.toggle()
        let imageName = pinTextField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
        showPinButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc private func termsAndConditionsTapped() {
        print("Terms and conditions tapped!")
    }
    
    @objc private func payButtonTapped() {
        print("Pay button tapped!")
        guard let product = selectedProduct, let phoneNumber = phoneNumber else {
            print("Cannot process payment: Missing product or phone number")
            return
        }
        
        guard let pinText = pinTextField.text, !pinText.isEmpty else {
            pinErrorMessageLabel.text = "PIN tidak boleh kosong."
            pinErrorMessageLabel.isHidden = false
            delegate?.transactionPageViewDidEncounterPinError(message: "PIN tidak boleh kosong.")
            return
        }
        
        pinErrorMessageLabel.isHidden = true
        
        print("Processing payment for \(product.label) to \(phoneNumber) with PIN (hidden)")
        
        delegate?.transactionPageViewDidRequestPayment(for: product.productCode, phoneNumber: phoneNumber, pin: pinText)
    }
}
