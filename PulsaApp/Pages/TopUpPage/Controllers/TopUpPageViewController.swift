//
//  TopUpPageViewController.swift
//  PulsaApp
//
//  Created by Balqis on 16/05/25.
//

import Foundation
import UIKit

class TopUpPageViewController: UIViewController {
    
    private let topUpPageView = TopUpPageView()
    
    private let pulsaVC = PulsaViewController()
    private let dataPackageVC = DataPackageViewController()
    
    override func loadView() {
        view = topUpPageView
        setupNavigationTitle("Top Up")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topUpPageView.delegate = self
        
        pulsaVC.delegate = self
        
        setupChildViewControllers()
    }

    private func setupChildViewControllers() {
        addChild(pulsaVC)
        topUpPageView.containerView.addSubview(pulsaVC.view)
        pulsaVC.view.anchor(top: topUpPageView.containerView.topAnchor,
                            left: topUpPageView.containerView.leftAnchor,
                            bottom: topUpPageView.containerView.bottomAnchor,
                            right: topUpPageView.containerView.rightAnchor)
        pulsaVC.didMove(toParent: self)
        
        addChild(dataPackageVC)
        topUpPageView.containerView.addSubview(dataPackageVC.view)
        dataPackageVC.view.anchor(top: topUpPageView.containerView.topAnchor,
                                  left: topUpPageView.containerView.leftAnchor,
                                  bottom: topUpPageView.containerView.bottomAnchor,
                                  right: topUpPageView.containerView.rightAnchor)
        dataPackageVC.didMove(toParent: self)
        
        dataPackageVC.view.isHidden = true
    }
}

extension TopUpPageViewController: TopUpPageViewDelegate {
    func didSelectSegment(at index: Int) {
        if index == 0 {
            pulsaVC.view.isHidden = false
            dataPackageVC.view.isHidden = true
        } else {
            pulsaVC.view.isHidden = true
            dataPackageVC.view.isHidden = false
        }
    }
}

extension TopUpPageViewController: PulsaViewDelegate {
    func showVoucherList() {
        let voucherListVC = VoucherPageViewController()
        navigationController?.pushViewController(voucherListVC, animated: true)
    }
    
    func phoneNumberAlert(message: String) {
        self.showAlert(title: "Masukkan Nomor Telpon", message: message)
    }
    
    func didSelectPulsaProduct(_ product: ProductItems, phoneNumber: String) {
        
        let transactionVC = TransactionPageViewController()
        transactionVC.selectedProduct = product
        transactionVC.phoneNumber = phoneNumber
        
        if let navController = navigationController {
            navController.pushViewController(transactionVC, animated: true)
        } else {
            print("ERROR: Navigation controller is nil. Cannot push view controller.")
        }
    }
    
    func resetPhoneNumberInPulsaVC() {
        pulsaVC.resetPhoneNumber()
    }

}
