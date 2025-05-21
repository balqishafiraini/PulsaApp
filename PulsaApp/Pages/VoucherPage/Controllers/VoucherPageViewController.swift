//
//  VoucherPageViewController.swift
//  PulsaApp
//
//  Created by Balqis on 17/05/25.
//

import UIKit

protocol VoucherPageViewControllerDelegate: AnyObject {
    func didSelectVoucher(_ voucher: VoucherItems)
}

class VoucherPageViewController: UIViewController {
    
    weak var delegate: VoucherPageViewControllerDelegate?

    private lazy var voucherListView: VoucherPageView = {
        let view = VoucherPageView()
        view.delegate = self
        return view
    }()

    override func loadView() {
        view = voucherListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle("Voucher Saya")
        loadVouchers()
    }

    private func loadVouchers() {
        if let response = VoucherAPI.shared.loadVoucherData() {
            voucherListView.vouchers = response.data
        }
    }
}

extension VoucherPageViewController: VoucherPageViewDelegate {
    func didTapUseButton(for voucher: VoucherItems) {
        delegate?.didSelectVoucher(voucher)
        navigationController?.popViewController(animated: true) 
    }
}
