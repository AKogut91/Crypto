//
//  Date.swift
//  Crypto
//
//  Created by AlexanderKogut on 9/25/19.
//  Copyright © 2019 AlexanderKogut. All rights reserved.
//

import Cocoa

extension Date {
    
    enum dateType: String {
        case ddMMyyyyHHmmss = "dd/MM/yyyy HH:mm:ss"
        case ddMMyyyy = "dd/MM/yyyy"
        case MMyyyy = "MMMM yyyy"
        case ddMMMMyyyyHHmm = "dd MMMM yyyy HH:mm"
        case mY = "MMyyyy"
        case llll = "LLLL"
        case MMM = "MMM"
        case yyyyMMM = "MMM yyyy "
    }
    
    func currentTimeStamp() -> Int! {
        return Int(self.timeIntervalSince1970)
    }
    
    func getCurrentDate(type: dateType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue
        return dateFormatter.string(from: self)
    }
    
    func dateFromTimeStamp(type: dateType ,time: Int) -> String {
        let timeInterval  = time
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
}

