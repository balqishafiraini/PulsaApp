//
//  PulsaViewController.swift
//  PulsaApp
//
//  Created by Balqis on 17/05/25.
//

import UIKit

class PulsaViewController: UIViewController {
    
    lazy var pulsaView: PulsaView = {
        let view = PulsaView()
        return view
    }()
    
    weak var delegate: PulsaViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        pulsaView.delegate = self
        print("PulsaView delegate set for: \(Unmanaged.passUnretained(pulsaView).toOpaque())")
    }
    
    private func setupUI() {
        view.addSubview(pulsaView)
        pulsaView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor)
    }
}

extension PulsaViewController: PulsaViewDelegate {
    func phoneNumberAlert(message: String) {
        delegate?.phoneNumberAlert(message: message)
    }
    
    func didSelectPulsaProduct(_ product: ProductItems, phoneNumber: String) {
        delegate?.didSelectPulsaProduct(product, phoneNumber: phoneNumber)
    }

    func showVoucherList() {
        let voucherListVC = VoucherPageViewController()
        navigationController?.pushViewController(voucherListVC, animated: true)
    }
    
    func resetPhoneNumber() {
        pulsaView.resetPhoneNumber()
    }
}
