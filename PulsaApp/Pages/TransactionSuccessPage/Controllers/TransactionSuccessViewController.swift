//
//  TransactionSuccessViewController.swift
//  PulsaApp
//
//  Created by Balqis on 20/05/25.
//

import Foundation
import UIKit

class TransactionSuccessViewController: UIViewController {

    private let successView = TransactionSuccessView()
    private let pulsaView = PulsaView()
    var transactionStatusResponse: TransactionStatusResponse?
    var phoneNumber: String?

    override func loadView() {
        view = successView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle("Detail Pembayaran")
        setupNavigationItem()
        loadTransactionData()
        phoneNumberUpdate()
        successView.okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
    }

    private func setupNavigationItem() {
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        closeButton.tintColor = .white
        navigationItem.leftBarButtonItem = closeButton
    }

    private func loadTransactionData() {
        transactionStatusResponse = StatusPageAPI.shared.loadPulsaData()
        if let response = transactionStatusResponse {
            successView.configure(with: response)
        }
    }
    
    private func phoneNumberUpdate() {
        if let phoneNumber = phoneNumber {
            successView.setPhoneNumber(phoneNumber)
        }
    }

    @objc private func okButtonTapped() {
        navigateBackToTopUp()
    }

    @objc private func closeButtonTapped() {
        navigateBackToTopUp()
    }

    private func navigateBackToTopUp() {
        if let nav = navigationController {
            for vc in nav.viewControllers {
                if let topUpVC = vc as? TopUpPageViewController {
                    topUpVC.resetPhoneNumberInPulsaVC()
                    nav.popToViewController(topUpVC, animated: true)
                    return
                }
            }
            nav.popToRootViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }

}
