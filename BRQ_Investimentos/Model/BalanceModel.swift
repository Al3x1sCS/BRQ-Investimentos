//
//  BalanceModel.swift
//  BRQ_Investimentos
//
//  Created by user on 06/02/23.
//

import Foundation

class BalanceModel {
    var balance: Double
    
    var balanceLabelFormated: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        
        if let result = formatter.string(from: NSNumber(value: balance)) {
            return result
        }
        
        return "R$ 0.00"
    }
    
    init() {
        self.balance = 1000.0
    }
}

