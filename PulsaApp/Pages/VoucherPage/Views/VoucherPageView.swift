//
//  VoucherPageView.swift
//  PulsaApp
//
//  Created by Balqis on 18/05/25.
//

import Foundation
import UIKit

protocol VoucherPageViewDelegate: AnyObject {
    func didTapUseButton(for voucher: VoucherItems)
}

class VoucherPageView: UIView {
    var vouchers: [VoucherItems] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    weak var delegate: VoucherPageViewDelegate?

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .white
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VoucherListCell.self, forCellReuseIdentifier: VoucherListCell.identifier)
    }
}

extension VoucherPageView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vouchers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VoucherListCell.identifier, for: indexPath) as? VoucherListCell else {
            return UITableViewCell()
        }
        let voucher = vouchers[indexPath.row]
        cell.configure(with: voucher)
        cell.onUseButtonTapped = { [weak self] in
            self?.delegate?.didTapUseButton(for: voucher)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
