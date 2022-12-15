//
//  ExchangeViewModel.swift
//  BRQ_Investimentos
//
//  Created by user on 10/12/22.
//

import Foundation
import UIKit

class ExchangeViewModel {
    
    private var exchangeView: ExchangeView
    var exchangeModel: ExchangeModel
    private var balanceModel: BalanceViewModel?
    private var navigationController: UINavigationController?
    private var message: String?
    
    init(_ exchangeView: ExchangeView, _ viewExchangeModel: ExchangeModel, balanceModel: BalanceViewModel = BalanceViewModel() ,_ navigationController: UINavigationController?) {
        self.exchangeView = exchangeView
        self.exchangeModel = viewExchangeModel
        self.balanceModel = balanceModel
        self.navigationController = navigationController
    }
    
    public func setAmountLabelText() {
        exchangeView.amountLabel.text = ""
    }
    
    public func settingStackViewLabels(currency: ExchangeModel) {
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
              let coinSigla = exchangeModel.coin.sigla,
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
        let coin = exchangeModel.coin
        
        guard let user = balanceModel,
              let coinSell = coin.sell,
              let coinSigla = exchangeModel.coin.sigla,
              let inputAmount = exchangeView.amountLabel.text,
              let amount = Int(inputAmount) else { return }

        let coinName = exchangeModel.coin.name
        let total = Utils.coinFormatter(number: (coinSell)*(Double(amount)))

        switch sender {
            case exchangeView.sellButton:
            user.transactions(operation: "sell", quantity: amount, coinSigla, coin)
                message = "Parabéns!\nVocê acabou de vender\n\(amount) \(coinSigla) - \(coinName),\n totalizando\n\(total)"
                buyAndSellNavigation(title: "Venda")
            case exchangeView.buyButton:
            user.transactions(operation: "buy", quantity: amount, coinSigla, coin)
                message = "Parabéns!\nVocê acabou de\ncomprar \(amount) \(coinSigla) - \n\(coinName), totalizando\n\(total)"
                buyAndSellNavigation(title: "Compra")
            default:
                break
        }

        exchangeView.balanceLabel.text = "Saldo disponível: \(user.balanceLabelFormated)"
        exchangeView.cashierLabel.text = "\(String(user.userWallet[coinSigla] ?? 0)) \(coinName) em caixa"
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        guard let balance = balanceModel,
              let coinBuy = exchangeModel.coin.buy,
              let amountLabelText = exchangeView.amountLabel.text,
              let amountTextInt = Int(amountLabelText),
              let coinSigla = exchangeModel.coin.sigla,
              let wallet = balance.userWallet[coinSigla],
              let amountTextDouble = Double(amountLabelText) else { return }
        
        let balanceDividedByPurchase = (balance.balance ) / (coinBuy)
        let sellPrice = exchangeModel.coin.sell ?? 0
        
        switch true {
            case amountLabelText == "":
                exchangeView.buyButton.isEnabled = false
                exchangeView.sellButton.isEnabled = false
            case amountTextDouble > balanceDividedByPurchase:
                exchangeView.buyButton.isEnabled = false
            case amountTextInt > wallet:
                exchangeView.sellButton.isEnabled = false
            case sellPrice <= 0:
                exchangeView.sellButton.isEnabled = false
            default:
                exchangeView.buyButton.isEnabled = true
                exchangeView.sellButton.isEnabled = true
        }
    }
    
}
