//
//  ExchangeModel.swift
//  BRQ_Investimentos
//
//  Created by user on 24/10/22.
//

import Foundation
import UIKit

struct CoinModel {
    let name: String
    let sigla: String
    let variation: Double
    let buy: Double
    let sell: Double
    let coin: Coins
    
    init(currency: Coins) {
        self.coin = currency
        self.name = currency.name
        self.sigla = currency.sigla ?? "USD"
        self.variation = currency.variation
        self.buy = currency.buy ?? 0
        self.sell = currency.sell ?? 0
    }
}
