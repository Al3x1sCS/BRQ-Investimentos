//
//  BalanceModel.swift
//  BRQ_Investimentos
//
//  Created by user on 07/11/22.
//

import Foundation

class BalanceViewModel {
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

    func transactions(operation: String, quantity: Int, _ currencyIso: String, _ currency: Coins) {
        guard let walletAmount = userWallet[currencyIso],
              let sellPrice = currency.sell,
              let buyPrice = currency.buy else { return }

        let totalSellPrice = sellPrice * Double(quantity)
        let totalBuyPrice = buyPrice * Double(quantity)

        switch operation {
        case "sell":
            guard walletAmount >= quantity else { return }
            balance += totalSellPrice
            userWallet[currencyIso] = walletAmount - quantity
        case "buy":
            guard balance - totalBuyPrice > 0 else { return }
            userWallet[currencyIso] = walletAmount + quantity
            balance -= totalBuyPrice
        default:
            break
        }
    }
    
}
