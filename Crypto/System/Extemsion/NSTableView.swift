//
//  NSTableView.swift
//  Crypto
//
//  Created by AlexanderKogut on 9/25/19.
//  Copyright © 2019 AlexanderKogut. All rights reserved.
//

import Cocoa

extension NSTableView {
    
    enum Colom: String {
        case colomOne, colomTwo, colomTree, colomFour, colomFive, colomSix
    }
    
    enum CellId: String {
        case icon, name, price, change_24h, change_1h,change_7d
    }

    func getAllColom() -> [Colom] {
        let array: [Colom] = [.colomOne, .colomTwo, .colomTree, .colomFour, .colomFive]
        return array
    }
    
    func getColom(_ colom: Colom) -> String {
        return colom.rawValue
    }
    
    func getCellID(_ cellID: CellId) -> String {
        return cellID.rawValue
    }
}
