//
//  JSONFormatter.swift
//  PulsaApp
//
//  Created by Balqis on 16/05/25.
//

import Foundation

struct JSONFormatter {
    static func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let decoded = try decoder.decode(type, from: data)
            return decoded
        } catch {
            print("JSON decode failed: \(error)")
            return nil
        }
    }
}
