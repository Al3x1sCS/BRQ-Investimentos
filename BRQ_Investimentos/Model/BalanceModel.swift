//
//  BalanceModel.swift
//  BRQ_Investimentos
//
//  Created by user on 07/11/22.
//

import Foundation

class BalanceModel {
    var balance: Double
    var userWallet: [String: Int]
    
    let apiCurrencies = ["USD", "EUR", "GBP", "ARS", "AUD", "BTC", "CAD", "CNY", "JPY"]
    
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
        var wallet = [String: Int]()
        
        for iso in apiCurrencies {
            wallet[iso] = 7
        }
        self.userWallet = wallet
    }
    
    func transactions(_ operation: String, quantity: Int, _ currencyIso: String, _ currency: Coins) {
        guard let currencyAmount = userWallet[currencyIso],
              let sellCoinPrice = currency.sell,
              let buyCoinPrice = currency.buy else { return }
        
        let sellPrice = sellCoinPrice * Double(quantity)
        let price = buyCoinPrice * Double(quantity)
        
        if operation == "sell" {
            if currencyAmount >= quantity {
                balance += sellPrice
                userWallet[currencyIso] = currencyAmount - quantity
            }
        } else {
            if balance - price > 0 {
                userWallet[currencyIso] = currencyAmount + quantity
                balance -= price
            }
        }
    }
    
}
