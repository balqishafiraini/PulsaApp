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
                print("Transaction Page updating view with: \(product.nominal) for \(number)")
                transactionPageView.selectedProduct = product
                transactionPageView.phoneNumber = number
                transactionPageView.appliedVoucher = appliedVoucher
                transactionPageView.updateVoucherDisplay()
            }
        }
}

extension TransactionPageViewController: TransactionPageViewDelegate {
    func transactionPageViewDidTapVoucher(_ view: TransactionPageView) {
        let voucherVC = VoucherPageViewController()
        voucherVC.delegate = self
        navigationController?.pushViewController(voucherVC, animated: true)
    }

    func transactionPageViewDidRequestPayment(for productCode: String, phoneNumber: String, pin: String) {
        let successVC = TransactionSuccessViewController()
        successVC.phoneNumber = phoneNumber

        if let response = StatusPageAPI.shared.loadPulsaData() {
            successVC.transactionStatusResponse = response
            navigationController?.pushViewController(successVC, animated: true)
        } else {
            showAlert(title: "Error", message: "Failed to load transaction data")
        }
    }


    func transactionPageViewDidEncounterPinError(message: String) {
        self.showAlert(title: "PIN Salah", message: "Masukkan PIN Anda")
    }
    
    func transactionPageViewDidRemoveVoucher(_ view: TransactionPageView) {
            print("Voucher removed from transaction page")
            appliedVoucher = nil
        }
}

extension TransactionPageViewController: VoucherPageViewControllerDelegate {
    func didSelectVoucher(_ voucher: VoucherItems) {
        print("Voucher \(voucher.name) selected in TransactionPage.")
        appliedVoucher = voucher
    }
}

