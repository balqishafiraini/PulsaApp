//
//  TransactionPageViewController.swift
//  PulsaApp
//
//  Created by Balqis on 17/05/25.
//

import Foundation
import UIKit

class TransactionPageViewController: UIViewController {

    private let transactionPageView = TransactionPageView()

    var selectedProduct: ProductItems? {
        didSet {
            updateTransactionViewIfLoaded()
        }
    }
    
    var phoneNumber: String? {
        didSet {
            updateTransactionViewIfLoaded()
        }
    }
    
    var appliedVoucher: VoucherItems? {
        didSet {
            updateTransactionViewIfLoaded()
        }
    }

    override func loadView() {
        view = transactionPageView
        setupNavigationTitle("Konfirmasi Pembayaran")
        transactionPageView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("TransactionPageViewController viewDidLoad")
        updateTransactionViewIfLoaded()
    }
    
    
    
    private func updateTransactionViewIfLoaded() {
            guard isViewLoaded else { return }

            if let product = selectedProduct, let number = phoneNumber {
                print("✅ Transaction Page updating view with: \(product.nominal) for \(number)")
                transactionPageView.selectedProduct = product
                transactionPageView.phoneNumber = number
                transactionPageView.appliedVoucher = appliedVoucher // Set voucher ke view
                transactionPageView.updateVoucherDisplay() // Panggil fungsi untuk update tampilan voucher
            }
        }
}

extension TransactionPageViewController: TransactionPageViewDelegate {
    func transactionPageViewDidTapVoucher(_ view: TransactionPageView) {
        let voucherVC = VoucherPageViewController()
        voucherVC.delegate = self // Set self sebagai delegate
        navigationController?.pushViewController(voucherVC, animated: true)
    }

    func transactionPageViewDidRequestPayment(for productCode: String, phoneNumber: String, pin: String) {
            // Create and configure TransactionSuccessViewController
            let successVC = TransactionSuccessViewController()
            
            // Get transaction status response from API
            if let response = StatusPageAPI.shared.loadPulsaData() {
                successVC.transactionStatusResponse = response
                
                // Push the success view controller
                navigationController?.pushViewController(successVC, animated: true)
            } else {
                // Handle error case
                showAlert(title: "Error", message: "Failed to load transaction data")
            }
        }


    func transactionPageViewDidEncounterPinError(message: String) {
        self.showAlert(title: "PIN Salah", message: "Masukkan PIN Anda")
    }
}

extension TransactionPageViewController: VoucherPageViewControllerDelegate {
    func didSelectVoucher(_ voucher: VoucherItems) {
        print("Voucher \(voucher.name) selected in TransactionPage.")
        appliedVoucher = voucher
    }
}

