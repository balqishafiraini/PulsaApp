//
//  PulsaAPI.swift
//  PulsaApp
//
//  Created by Balqis on 16/05/25.
//

import Foundation

class PulsaAPI {
    static let shared = PulsaAPI()

    private init() {}

    func loadPulsaData() -> ProductResponse? {
        let jsonString = """
        {
          "status": "OK",
          "message": "OK",
          "products": [
            {
              "product_code": "Fw22lyO0",
              "bill_type": "mobile",
              "label": "XL Rp 10.000",
              "provider": "xl",
              "nominal": "10000",
              "description": "",
              "sequence": 1,
              "price": 11000
            },
            {
              "product_code": "Oq0ckhPY2",
              "bill_type": "mobile",
              "label": "XL 15,000",
              "provider": "xl",
              "nominal": "15000",
              "description": "",
              "price": 16000
            },
            {
              "product_code": "Oq0ckhPY3",
              "bill_type": "mobile",
              "label": "XL 25,000",
              "provider": "xl",
              "nominal": "25000",
              "description": "",
              "price": 26000
            },
            {
              "product_code": "Oq0ckhPY4",
              "bill_type": "mobile",
              "label": "XL 50,000",
              "provider": "xl",
              "nominal": "50000",
              "description": "",
              "price": 51000
            },
            {
              "product_code": "Oq0ckhPY5",
              "bill_type": "mobile",
              "label": "XL 100,000",
              "provider": "xl",
              "nominal": "100000",
              "description": "",
              "price": 101000
            }
          ]
        }
        """

        guard let data = jsonString.data(using: .utf8) else {
            print("Failed to convert JSON string to data")
            return nil
        }

        return JSONFormatter.decode(ProductResponse.self, from: data)
    }
}
