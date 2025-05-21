import Foundation
import UIKit

protocol PulsaViewDelegate: AnyObject {
    func didSelectPulsaProduct(_ product: ProductItems, phoneNumber: String)
    func showVoucherList()
    func phoneNumberAlert(message: String)
}

class PulsaView: UIView {

    private var pulsaProducts: [ProductItems] = []
    private var vouchers: [VoucherItems] = []
            
    weak var delegate: PulsaViewDelegate?

    private lazy var headerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var iconImage: UIImageView = {
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

    private lazy var mobileNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Mobile number"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()

    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter phone number"
        textField.textColor = .darkGray
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.keyboardType = .numberPad
        textField.clearButtonMode = .never
        return textField
    }()
    
    private lazy var textFieldBottomBorder: UIView = {
        let border = UIView()
        border.backgroundColor = .systemGray3
        return border
    }()

    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        return button
    }()

    private lazy var contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(openContacts), for: .touchUpInside)
        return button
    }()

    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()

    private lazy var pulsaOptionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var promoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var promosLabel: UILabel = {
        let label = UILabel()
        label.text = "Promos"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    private lazy var voucherScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var voucherStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private var cardWidth: CGFloat = 0
    private var cardHeight: CGFloat = 0
    
    private let voucherScrollViewPaddingLeftRight: CGFloat = 16

    override init(frame: CGRect) {
        super.init(frame: frame)
        print("PulsaView initialized: \(Unmanaged.passUnretained(self).toOpaque())")
        setupViews()
        setupPromoContainer()
        loadPulsaData()
        loadVoucherData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .systemGray5
        
        addSubview(headerContainerView)
        headerContainerView.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            height: 80
        )

        headerContainerView.addSubview(iconImage)
        iconImage.anchor(
            left: headerContainerView.leftAnchor,
            paddingLeft: 16,
            width: 40,
            height: 40
        )
        iconImage.centerY(inView: headerContainerView)

        headerContainerView.addSubview(contactButton)
        contactButton.anchor(
            right: headerContainerView.rightAnchor,
            paddingRight: 16,
            width: 20,
            height: 20
        )
        contactButton.centerY(inView: headerContainerView)

        headerContainerView.addSubview(clearButton)
        clearButton.anchor(
            right: contactButton.leftAnchor,
            paddingRight: 8,
            width: 20,
            height: 20
        )
        clearButton.centerY(inView: headerContainerView)

        headerContainerView.addSubview(mobileNumberLabel)
        mobileNumberLabel.anchor(
            top: headerContainerView.topAnchor,
            left: iconImage.rightAnchor,
            paddingTop: 8,
            paddingLeft: 12
        )

        headerContainerView.addSubview(phoneNumberTextField)
        phoneNumberTextField.anchor(
            top: mobileNumberLabel.bottomAnchor,
            left: iconImage.rightAnchor,
            right: clearButton.leftAnchor,
            paddingLeft: 12,
            paddingRight: 4,
            height: 40
        )
        
        phoneNumberTextField.addSubview(textFieldBottomBorder)
        textFieldBottomBorder.anchor(
            left: phoneNumberTextField.leftAnchor,
            bottom: phoneNumberTextField.bottomAnchor,
            right: clearButton.rightAnchor,
            height: 1)
        
        addSubview(scrollView)
        scrollView.anchor(
            top: headerContainerView.bottomAnchor,
            left: leftAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            right: rightAnchor,
            paddingTop: 10
        )

        scrollView.addSubview(pulsaOptionsStackView)
        pulsaOptionsStackView.anchor(
            top: scrollView.topAnchor,
            left: scrollView.leftAnchor,
            right: scrollView.rightAnchor
        )
        pulsaOptionsStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollView.addSubview(promoContainerView)
        promoContainerView.anchor(
            top: pulsaOptionsStackView.bottomAnchor,
            left: scrollView.leftAnchor,
            right: scrollView.rightAnchor,
            paddingTop: 10
        )
        
        promoContainerView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setupPromoContainer() {
        promoContainerView.addSubview(promosLabel)
        promoContainerView.addSubview(voucherScrollView)

        promosLabel.anchor(
            top: promoContainerView.topAnchor,
            left: promoContainerView.leftAnchor,
            right: promoContainerView.rightAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingRight: 16
        )

        voucherScrollView.anchor(
            top: promosLabel.bottomAnchor,
            left: promoContainerView.leftAnchor,
            bottom: promoContainerView.bottomAnchor,
            right: promoContainerView.rightAnchor,
            paddingTop: 12,
            paddingLeft: 16,
            paddingBottom: 16,
            paddingRight: 16
        )
        
        voucherScrollView.addSubview(voucherStackView)
        voucherStackView.anchor(
            top: voucherScrollView.topAnchor,
            left: voucherScrollView.leftAnchor,
            bottom: voucherScrollView.bottomAnchor,
            right: voucherScrollView.rightAnchor
        )
        voucherStackView.heightAnchor.constraint(equalTo: voucherScrollView.heightAnchor).isActive = true
    }

    private func loadPulsaData() {
        if let productResponse = PulsaAPI.shared.loadPulsaData() {
            self.pulsaProducts = productResponse.products
            DispatchQueue.main.async {
                self.createPulsaOptions()
            }
        }
    }

    private func loadVoucherData() {
        if let voucherResponse = VoucherAPI.shared.loadVoucherData() {
            self.vouchers = voucherResponse.data
            DispatchQueue.main.async {
                self.displayVouchers()
            }
        }
    }

    private func createPulsaOptions() {
        pulsaOptionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for product in pulsaProducts {
            let pulsaView = createPulsaOptionView(for: product)
            pulsaOptionsStackView.addArrangedSubview(pulsaView)
        }
    }

    private func displayVouchers() {
        voucherStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let screenWidth = UIScreen.main.bounds.width
        
        let totalHorizontalPaddingForVoucherScrollView = voucherScrollViewPaddingLeftRight * 2
        let usableWidthForCards = screenWidth - totalHorizontalPaddingForVoucherScrollView
        
        cardWidth = usableWidthForCards * 0.80
        
        cardHeight = cardWidth / 2.0
        voucherScrollView.heightAnchor.constraint(equalToConstant: cardHeight).isActive = true
        
        for voucher in vouchers {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 8
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = true
            imageView.tag = voucher.id

            imageView.loadImage(from: voucher.imageUrl)

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(voucherImageTapped(_:)))
            imageView.addGestureRecognizer(tapGesture)
            
            imageView.widthAnchor.constraint(equalToConstant: cardWidth).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: cardHeight).isActive = true

            voucherStackView.addArrangedSubview(imageView)
        }
    }

    private func createPulsaOptionView(for product: ProductItems) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.heightAnchor.constraint(equalToConstant: 70).isActive = true

        let nominalLabel = UILabel()
        nominalLabel.text = "Nominal:"
        nominalLabel.textColor = .gray
        nominalLabel.font = UIFont.systemFont(ofSize: 14)

        let amountLabel = UILabel()
        amountLabel.text = "\(product.nominalInt.formattedWithSeparator)"
        amountLabel.textColor = .darkGray
        amountLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)

        let button = UIButton(type: .system)
        button.setTitle(product.formattedPrice, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.tag = product.nominalInt
        button.accessibilityIdentifier = product.productCode
        button.addTarget(self, action: #selector(pulsaButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 6
        
        let separator = UIView()
        containerView.addSubview(separator)

        containerView.addSubview(nominalLabel)
        containerView.addSubview(amountLabel)
        containerView.addSubview(button)

        nominalLabel.anchor(
            top: containerView.topAnchor,
            left: containerView.leftAnchor,
            paddingTop: 12,
            paddingLeft: 16
        )

        amountLabel.anchor(
            top: nominalLabel.bottomAnchor,
            left: containerView.leftAnchor,
            paddingTop: 4,
            paddingLeft: 16
        )

        button.anchor(
            right: containerView.rightAnchor,
            paddingRight: 16,
            width: 120,
            height: 44
        )
        button.centerY(inView: containerView)
            
        separator.anchor(
            left: containerView.leftAnchor,
            bottom: containerView.bottomAnchor,
            right: containerView.rightAnchor,
            height: 1.0
        )

        return containerView
    }
    
    func resetPhoneNumber() {
        phoneNumberTextField.text = ""
    }

    @objc private func pulsaButtonTapped(_ sender: UIButton) {
        let nominal = sender.tag
        let productCode = sender.accessibilityIdentifier ?? ""

        print("Pulsa button tapped. Nominal: \(nominal), Product Code: \(productCode)")

        let enteredPhoneNumber = phoneNumberTextField.text ?? ""

        guard enteredPhoneNumber.count >= 4 else {
            delegate?.phoneNumberAlert(message: "Anda Belum memasukkan nomor telpon dengan minimal 4 digit angka")
            return
        }

        if let selectedProduct = pulsaProducts.first(where: { $0.nominalInt == nominal && $0.productCode == productCode }) {
            print("Product found: \(selectedProduct.label)")
            delegate?.didSelectPulsaProduct(selectedProduct, phoneNumber: enteredPhoneNumber)
        } else {
            print("DEBUG: Product not found for nominal \(nominal) and product code \(productCode).")
        }
    }
    
    @objc private func voucherImageTapped(_ sender: UITapGestureRecognizer) {
        delegate?.showVoucherList()
    }


    @objc private func clearTextField() {
        phoneNumberTextField.text = ""
    }

    @objc private func openContacts() {
        print("Open contacts button tapped.")
    }
    
}
