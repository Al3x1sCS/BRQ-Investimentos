//
//  ExchangeViewModel.swift
//  BRQ_Investimentos
//
//  Created by user on 10/12/22.
//

import Foundation
import UIKit

class ExchangeViewModel: ExchangeViewModelProtocol {
    
    let exchangeView: ExchangeView
    var coinModel: CoinModel
    let balanceModel: BalanceViewModel?
    let navigationController: UINavigationController?
    private var message: String?
    
    init(exchangeView: ExchangeView, coinModel: CoinModel, balanceModel: BalanceViewModel? = BalanceViewModel(), navigationController: UINavigationController?) {
            self.exchangeView = exchangeView
            self.coinModel = coinModel
            self.balanceModel = balanceModel
            self.navigationController = navigationController
        }
    
    public func setAmountLabelText() {
        exchangeView.amountLabel.text = ""
    }
    
    public func settingStackViewLabels(currency: CoinModel) {
        exchangeView.currencyLabel.text = "\(currency.sigla) - \(currency.name)"
        exchangeView.variationLabel.text = "\(String(format: "%.2f", currency.variation))%"
        exchangeView.purchaseLabel.text = "Compra: \(Utils.coinFormatter(number: currency.buy))"
        exchangeView.saleLabel.text = "Venda: \(Utils.coinFormatter(number: currency.sell))"
        exchangeView.balanceLabel.text = "Saldo disponível: \(balanceModel?.balanceLabelFormated ?? "")"
        exchangeView.cashierLabel.text = "\(balanceModel?.userWallet[currency.coin.sigla ?? ""] ?? 0) \(currency.coin.name) em caixa"
        
        switch currency.variation {
        case let total where total > 0:
            exchangeView.variationLabel.textColor = .variationGreen()
        case let total where total < 0:
            exchangeView.variationLabel.textColor = .variationRed()
        default:
            exchangeView.variationLabel.textColor = .white
        }
    }
    
    public func updateButtonsState() {
        guard let user = balanceModel,
              let coinSigla = coinModel.coin.sigla,
              let wallet = user.userWallet[coinSigla] else { return }

        let sellButton = exchangeView.sellButton
        sellButton.isEnabled = false
        
        let buyButton = exchangeView.buyButton
        buyButton.isEnabled = false

        guard wallet > 0 else {
            sellButton.isEnabled = false
            return
        }

        guard balanceModel?.balance ?? 0 > 0 else {
            buyButton.isEnabled = false
            return
        }
    }
    
    public func setTargets() {
        exchangeView.sellButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        exchangeView.buyButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        exchangeView.amountLabel.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func buyAndSellNavigation(title: String) {
        let viewController = BuyAndSellViewController()
        viewController.setupNavigation(with: title)
        viewController.message = message
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        let currency = coinModel.coin
        
        guard let user = balanceModel,
              let coinSell = currency.sell,
              let coinSigla = currency.sigla,
              let inputAmount = exchangeView.amountLabel.text,
              let amount = Int(inputAmount) else { return }

        let coinName = currency.name
        let total = Utils.coinFormatter(number: (coinSell)*(Double(amount)))
        let userWalletValue = user.userWallet[coinSigla]
        let userWalletString = userWalletValue != nil ? String(userWalletValue!) : "0"

        switch sender {
            case exchangeView.sellButton:
            user.transactions(operation: "sell", quantity: amount, coinSigla, currency)
                message = "Parabéns!\nVocê acabou de vender\n\(amount) \(coinSigla) - \(coinName),\n totalizando\n\(total)"
                buyAndSellNavigation(title: "Venda")
            case exchangeView.buyButton:
            user.transactions(operation: "buy", quantity: amount, coinSigla, currency)
                message = "Parabéns!\nVocê acabou de\ncomprar \(amount) \(coinSigla) - \n\(coinName), totalizando\n\(total)"
                buyAndSellNavigation(title: "Compra")
            default:
                break
        }

        exchangeView.balanceLabel.text = "Saldo disponível: \(user.balanceLabelFormated)"
        exchangeView.cashierLabel.text = "\(userWalletString) \(coinName) em caixa"
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        guard let amountLabelText = exchangeView.amountLabel.text else { return }
        
        if amountLabelText == "" {
            exchangeView.buyButton.isEnabled = false
            exchangeView.sellButton.isEnabled = false
            return
        }
        
        guard let balance = balanceModel,
              let amountTextInt = Int(amountLabelText),
              let wallet = balance.userWallet[coinModel.sigla],
              let amountTextDouble = Double(amountLabelText) else { return }
        
        let balanceDividedByPurchase = (balance.balance ) / (coinModel.buy)
        
        if amountTextDouble > balanceDividedByPurchase {
            exchangeView.buyButton.isEnabled = false
        } else {
            exchangeView.buyButton.isEnabled = true
        }
        
        if amountTextInt > wallet {
            exchangeView.sellButton.isEnabled = false
        } else if coinModel.sell <= 0 {
            exchangeView.sellButton.isEnabled = false
        } else {
            exchangeView.sellButton.isEnabled = true
        }
    }

    
}
