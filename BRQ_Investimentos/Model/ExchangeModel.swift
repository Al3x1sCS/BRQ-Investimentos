//
//  ExchangeModel.swift
//  BRQ_Investimentos
//
//  Created by user on 24/10/22.
//

import Foundation
import UIKit

struct ExchangeModel {
    let name: String
    let sigla: String
    let variation: Double
    let buy: Double
    let sell: Double
    let coin: Coins
    
    init(coin: Coins) {
        self.coin = coin
        self.name = coin.name
        self.sigla = coin.sigla ?? "USD"
        self.variation = coin.variation
        self.buy = coin.buy ?? 0
        self.sell = coin.sell ?? 0
    }
}
