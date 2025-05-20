//
//  StatusPageModel.swift
//  PulsaApp
//
//  Created by Balqis on 19/05/25.
//

import Foundation

struct TransactionStatusResponse: Codable {
    let message: String
    let status: String
    let transactionContext: TransactionContext
}

struct TransactionContext: Codable {
    let transactionStatus: Int
    let merchantDetails: MerchantDetails
    let appliedPaymentType: String
    let checkoutAmount: String
    let orderId: String
    let itemList: [TransactionItem]
    let expirationTime: String
    let amount: String
    let transactionToken: String
}

struct MerchantDetails: Codable {
    let logoUrl: String
    let name: String
}

struct TransactionItem: Codable {
    let aggregatedPrice: String?
    let quantity: Int
    let status: String?
    let unitPrice: String?
    let totalAmount: String
    let pId: Int?
    let skuType: Int
    let name: String
    let category: String?
    let sku: String
}
