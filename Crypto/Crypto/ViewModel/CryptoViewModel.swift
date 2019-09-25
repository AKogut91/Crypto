//
//  CryptoViewModel.swift
//  Crypto
//
//  Created by AlexanderKogut on 9/25/19.
//  Copyright © 2019 AlexanderKogut. All rights reserved.
//

import Foundation

class CryptoViewModel {
    
    var cryptoOBJ: [Datum]?
    private var networkService: NetworkService!
    
    init(networkService: NetworkService,completion: @escaping () -> ()) {
        self.networkService = networkService
        getCryptoData {
            completion()
        }
    }
    
    func getCryptoData(completion: @escaping () -> ()) {
        networkService.getCrypto { (obj) in
            self.cryptoOBJ = obj
            completion()
        }
    }
}
