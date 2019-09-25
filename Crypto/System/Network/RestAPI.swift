//
//  RestAPI.swift
//  Crypto
//
//  Created by AlexanderKogut on 9/25/19.
//  Copyright © 2019 AlexanderKogut. All rights reserved.
//

import Foundation

class RestAPI {

    func setCryptoicons(currency: String) -> String {
        return "https://cryptoicons.org/api/icon/\(currency.lowercased())/200"
    }
    
    enum Methods: String {
        case cryptoCurrency
        var description: String {
            switch self {
            case .cryptoCurrency:   return "https://api.coinlore.com/api/tickers/"
            }
        }
    }
}
