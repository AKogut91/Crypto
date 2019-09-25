//
//  CryptoNSViewController.swift
//  Crypto
//
//  Created by AlexanderKogut on 9/25/19.
//  Copyright © 2019 AlexanderKogut. All rights reserved.
//

import Cocoa

class CryptoNSViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var iconColom: NSTableHeaderView!
    @IBOutlet weak var lastUpdateLabel: NSTextField!
    var viewModel: CryptoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTable()
        viewModel = CryptoViewModel(networkService: NetworkService(), completion: {
            self.tableView.reloadData()
            self.setTimerForUpdateCrypto()
        })
    }
    
    private func setTable() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setTimerForUpdateCrypto() {
        Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { timer in
            self.viewModel.cryptoOBJ?.removeAll()
            self.viewModel.getCryptoData {
                self.tableView.reloadData()
                self.showUpdateLable()
            }
        }
    }
    
    private func showUpdateLable() {
        lastUpdateLabel.isHidden = false
        if let timeStamp = Date().currentTimeStamp() {
            let dateString = Date().dateFromTimeStamp(type: .ddMMyyyyHHmmss, time: timeStamp)
            lastUpdateLabel.stringValue = "Last Update: \(dateString)"
        }
    }
}

extension CryptoNSViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if viewModel != nil {
            return viewModel.cryptoOBJ?.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellData = viewModel.cryptoOBJ?[row]
        
        if tableColumn!.identifier.rawValue == tableView.getColom(.colomOne) {
            if let cellNumber = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: tableView.getCellID(.icon)), owner: self) as?  NSTableCellView {
                cellNumber.textField?.stringValue = String(row + 1)
                return cellNumber
            }
        } else if tableColumn!.identifier.rawValue == tableView.getColom(.colomTwo)  {
            let name = cellData?.name ?? ""
            let cellItem = setCell(cellDate: name, sing: "", cellId: tableView.getCellID(.name))
            return cellItem
            
        } else if tableColumn!.identifier.rawValue == tableView.getColom(.colomTree)  {
            let price = cellData?.priceUsd ?? ""
            let cellItem = setCell(cellDate: price, sing: "$", cellId: tableView.getCellID(.price))
            return cellItem
            
        } else if tableColumn!.identifier.rawValue == tableView.getColom(.colomFour)  {
            let price24 = cellData?.percentChange24H ?? ""
            let cellItem = setCell(cellDate: price24, sing: "%", cellId: tableView.getCellID(.change_24h), changeColor: true)
            return cellItem
            
        } else if tableColumn!.identifier.rawValue == tableView.getColom(.colomFive)  {
            let price1H = cellData?.percentChange1H ?? ""
            let cellItem = setCell(cellDate:price1H, sing: "%", cellId: tableView.getCellID(.change_1h), changeColor: true)
            return cellItem
            
        } else  {
            let price7D = cellData?.percentChange7D ?? ""
            let cellItem = setCell(cellDate: price7D,
                                   sing: "%", cellId: tableView.getCellID(.change_7d), changeColor: true)
            return cellItem
        }
        return nil
    }
    
    private func setCell(cellDate: String, sing: String, cellId:String, changeColor:Bool = false) -> NSTableCellView? {
        if let cellItem = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellId), owner: self) as?  NSTableCellView {
            if changeColor {
                if cellDate.hasPrefix("-") {
                    cellItem.textField?.textColor = NSColor.percentRed()
                } else {
                    cellItem.textField?.textColor = NSColor.percentGreen()
                }
                cellItem.textField?.font = NSFont.boldSystemFont(ofSize: 16)
            } else {
                cellItem.textField?.font = NSFont.labelFont(ofSize: 16)
            }
            cellItem.textField?.stringValue = "\(cellDate) \(sing)"
            return cellItem
        }
        return nil
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30
    }
}


