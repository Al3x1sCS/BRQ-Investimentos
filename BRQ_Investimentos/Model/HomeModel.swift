//
//  HomeViewModel.swift
//  BRQ_Investimentos
//
//  Created by user on 28/10/22.
//

import Foundation

protocol HomeModelProtocol {
    func updateView()
}

class HomeModel {
    
    let service = HGFinanceService()
    var coins: [Coins] = []
    var delegate: HomeModelProtocol?
    var viewModel: HomeModel?
    
    init(delegate: HomeModelProtocol) {
        self.delegate = delegate
        getCoins()
    }
    
    private func getCoins() {
        service.getData { result, failure in
            guard let result = result else { return }
            
            self.coins.append(result.results.currencies.USD)
            self.coins.append(result.results.currencies.EUR)
            self.coins.append(result.results.currencies.GBP)
            self.coins.append(result.results.currencies.ARS)
            self.coins.append(result.results.currencies.CAD)
            self.coins.append(result.results.currencies.AUD)
            self.coins.append(result.results.currencies.JPY)
            self.coins.append(result.results.currencies.CNY)
            self.coins.append(result.results.currencies.BTC)
            
            self.setSigla()
            self.delegate?.updateView()
        }
    }
    
    private func setSigla() {
        for (index, value) in Currencies.CodingKeys.allCases.enumerated() {
            if index > 0 {
                coins[(index - 1)].sigla = value.rawValue
            }
        }
    }
    
    func getVariation(index: Int) -> Double {
        return coins[index].variation
    }
    
}
