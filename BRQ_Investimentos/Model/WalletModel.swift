//
//  WalletModel.swift
//  BRQ_Investimentos
//
//  Created by user on 06/02/23.
//

import Foundation

class WalletModel {
    var userWallet: [String: Int]
    let apiCurrencies = ["USD", "EUR", "GBP", "ARS", "AUD", "BTC", "CAD", "CNY", "JPY"]
    
    init() {
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
            userWallet[currencyIso] = walletAmount - quantity
        case "buy":
            userWallet[currencyIso] = walletAmount + quantity
        default:
            break
        }
    }
}
