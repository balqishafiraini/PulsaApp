//
//  VoucherAPI.swift
//  PulsaApp
//
//  Created by Balqis on 17/05/25.
//

import Foundation

class VoucherAPI {
    static let shared = VoucherAPI()

    private init() {}

    func loadVoucherData() -> VoucherResponse? {
        let jsonString = """
        {
          "data": [
            {
              "name": "VOUCHERPROMO",
              "number": 4,
              "percentage": 10,
              "iterator": 0,
              "image_url": "https://placehold.co/1000x400/239CEC/FFFFFF/png",
              "min_transaction_amount": 50000,
              "end_date": "1682787599",
              "id": 4111,
              "terms_and_condition": "text",
              "how_to_use": "text",
              "usage_count": 2,
              "start_date": "1680282000",
              "max_discount": 20000,
              "voucher_code": "ACBDED88"
            },
            {
              "name": "VOUCHERZEROPERCENT",
              "number": 4,
              "percentage": 0,
              "iterator": 1,
              "image_url": "https://placehold.co/1000x400/239CEC/FFFFFF/png",
              "min_transaction_amount": 0,
              "end_date": "1682096399",
              "id": 4112,
              "terms_and_condition": "text",
              "how_to_use": "text",
              "usage_count": 0,
              "start_date": "1680195600",
              "max_discount": 0,
              "voucher_code": "ACBDED89"
            }
          ],
          "status": "OK"
        }
        """

        guard let data = jsonString.data(using: .utf8) else {
            print("Failed to convert JSON string to data")
            return nil
        }

        return JSONFormatter.decode(VoucherResponse.self, from: data)
    }
}
