//
//  VoucherModel.swift
//  PulsaApp
//
//  Created by Balqis on 16/05/25.
//

import Foundation


struct VoucherResponse: Codable {
    let data: [VoucherItems]
    let status: String
}

struct VoucherListModel {
    var vouchers: [VoucherItems]
}

struct VoucherItems: Codable {
    let name: String
    let number: Int
    let percentage: Int
    let iterator: Int
    let imageUrl: String
    let minTransactionAmount: Double
    let endDate: String
    let id: Int
    let termsAndCondition: String
    let howToUse: String
    let usageCount: Int
    let startDate: String
    let maxDiscount: Double
    let voucherCode: String
}
