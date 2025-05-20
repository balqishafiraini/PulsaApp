//
//  DataPackageViewController.swift
//  PulsaApp
//
//  Created by Balqis on 18/05/25.
//

import Foundation
import UIKit

class DataPackageViewController: UIViewController {
    private lazy var dataPackageView: DataPackageView = {
        let view = DataPackageView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dataPackageView)
    }
}
