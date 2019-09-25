//
//  NetworkService.swift
//  Crypto
//
//  Created by AlexanderKogut on 9/25/19.
//  Copyright © 2019 AlexanderKogut. All rights reserved.
//

import Foundation

class NetworkService {

    func getCrypto(completion: @escaping ([Datum]?) -> ()) {
        Request().apiRequest(link: .cryptoCurrency, method: .get) { (value) in
            do {
                if let jsonData = value.data {
                let acceptData = try JSONDecoder().decode(Crypto.self, from: jsonData)
                completion(acceptData.data)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
