//
//  Request.swift
//  Crypto
//
//  Created by AlexanderKogut on 9/25/19.
//  Copyright © 2019 AlexanderKogut. All rights reserved.
//

import Foundation
import Alamofire

typealias jsonValue = DataResponse<Any>

class Request {
    
    func apiRequest(link: RestAPI.Methods,
                    method: HTTPMethod,
                    complition: @escaping (jsonValue) -> ()) {
        
        print("request -> \(link.description)")
        Alamofire.request(link.description,
                          method: HTTPMethod(rawValue: method.rawValue)!)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    debugPrint("HTTP Response Body: \(String(describing: response.data))")
                    complition(response)
                    
                } else {
                    debugPrint("HTTP Request failed: \(String(describing: response.result.error))")
                }
        }
    }
}
