//
//  ExchangeViewModelProtocol.swift
//  BRQ_Investimentos
//
//  Created by user on 06/02/23.
//

import Foundation
import UIKit

protocol ExchangeViewModelProtocol {
    var exchangeView: ExchangeView { get }
    var coinModel: CoinModel { get }
    var balanceModel: BalanceViewModel? { get }
    var navigationController: UINavigationController? { get }
}
