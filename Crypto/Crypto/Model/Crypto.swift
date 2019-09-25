//
//  Crypto.swift
//  Crypto
//
//  Created by AlexanderKogut on 9/25/19.
//  Copyright © 2019 AlexanderKogut. All rights reserved.
//

import Foundation

// MARK: - Crypto
struct Crypto: Codable {
    let data: [Datum]?
    let info: Info?
}

// MARK: - Datum
struct Datum: Codable {
    let id, symbol, name, nameid: String?
    let rank: Int?
    let priceUsd, percentChange24H, percentChange1H, percentChange7D: String?
    let priceBtc, marketCapUsd: String?
    let volume24, volume24A: Double?
    let csupply: String?
    let tsupply: Tsupply?
    let msupply: String?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, nameid, rank
        case priceUsd = "price_usd"
        case percentChange24H = "percent_change_24h"
        case percentChange1H = "percent_change_1h"
        case percentChange7D = "percent_change_7d"
        case priceBtc = "price_btc"
        case marketCapUsd = "market_cap_usd"
        case volume24
        case volume24A = "volume24a"
        case csupply, tsupply, msupply
    }
}

enum Tsupply: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Tsupply.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Tsupply"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Info
struct Info: Codable {
    let coinsNum, time: Int?
    
    enum CodingKeys: String, CodingKey {
        case coinsNum = "coins_num"
        case time
    }
}
