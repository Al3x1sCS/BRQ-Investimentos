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
    /// Esta função realiza transações de compra ou venda de uma determinada moeda
    /// em sua carteira de usuário. Ele recebe uma operação ("sell" ou "buy"), uma
    /// quantidade, seu código ISO e uma moeda.
    /// - Parameters:
    ///   - operation: A operação a ser realizada. Deve ser "buy" para comprar ou "sell" para vender.
    ///   - quantity: A quantidade de moedas a ser comprada ou vendida.
    ///   - currencyIso: O código ISO da moeda a ser comprada ou vendida.
    ///   - currency: As informações da moeda a ser comprada ou vendida.
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
