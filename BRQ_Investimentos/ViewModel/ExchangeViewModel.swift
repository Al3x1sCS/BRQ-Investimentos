//
//  ExchangeViewModel.swift
//  BRQ_Investimentos
//
//  Created by user on 10/12/22.
//

import Foundation
import UIKit

class ExchangeViewModel {

    // MARK: - attributes
    private var exchangeModel: ExchangeModel?
    private var balanceViewModel: BalanceViewModel?
    private var exchangeView: ExchangeView?
    private var message: String?
    
    // MARK: - init
    init(exchangeModel: ExchangeModel, balanceViewModel: BalanceViewModel) {
        self.exchangeModel = exchangeModel
        self.balanceViewModel = balanceViewModel
    }
    
    // MARK: - public functions
    public func setupNavigation(with title: String) {
        setupNavigation(with: "Câmbio")
    }
    
    public func setTargets() {
        exchangeView?.sellButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        exchangeView?.buyButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        exchangeView?.amountLabel.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    public func buyAndSellNavigation(title: String) {
        // Código para navegar para a tela de compra e venda aqui
    }
    
    public func setAmountLabelText() {
        // Código para definir o texto do label de quantidade aqui
    }
    
    public func settingStackViewLabels() {
        // Código para configurar os labels da stack view aqui
    }
    
    public func settingBalanceWalletLabels() {
        // Código para configurar os labels da carteira de saldo aqui
    }
    
    public func setupButtons() {
        // Código para configurar os botões aqui
    }
    
    @objc func buttonTapped(sender: UIButton) {
        guard let user = balanceViewModel,
              let currency = exchangeModel?.coin,
              let coinSell = currency.sell,
              let viewExchangeModel = exchangeModel,
              let coinSigla = viewExchangeModel.coin.sigla,
              let stringInputAmount = exchangeView?.amountLabel.text,
              let intInputAmount = Int(stringInputAmount) else { return }

        let coinName = viewExchangeModel.coin.name
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        let total = String(formatter.string(from: NSNumber(value: (coinSell)*(Double(intInputAmount))))!)

        switch sender {
        case exchangeView?.sellButton:
                user.transactions("sell", quantity: intInputAmount, coinSigla, currency)
                message = "Parabéns!\nVocê acabou de vender\n\(intInputAmount) \(coinSigla) - \(coinName),\n totalizando\n\(total)"
                buyAndSellNavigation(title: "Venda")
        case exchangeView?.buyButton:
                user.transactions("buy", quantity: intInputAmount, coinSigla, currency)
                message = "Parabéns!\nVocê acabou de\ncomprar \(intInputAmount) \(coinSigla) - \n\(coinName), totalizando\n\(total)"
                buyAndSellNavigation(title: "Compra")
            default:
                break
        }

        exchangeView?.balanceLabel.text = "Saldo disponível: \(user.balanceLabelFormated)"
        exchangeView?.cashierLabel.text = "\(String(user.userWallet[coinSigla] ?? 0)) \(coinName) em caixa"
    }
    
    // MARK: - @objc textFieldDidChange
    @objc private func textFieldDidChange(textField: UITextField) {
        guard let balance = balanceViewModel,
              let coinBuy = exchangeModel?.coin.buy,
              let amountLabelText = exchangeView?.amountLabel.text,
              let amountTextInt = Int(amountLabelText),
              let coinSigla = exchangeModel?.coin.sigla,
              let wallet = balance.userWallet[coinSigla],
              let amountTextDouble = Double(amountLabelText) else { return }
        
        let balanceDividedByPurchase = (balance.balance ) / (coinBuy)
        let sellPrice = exchangeModel?.coin.sell ?? 0
        
        if amountLabelText == "" {
            exchangeView?.buyButton.isEnabled = false
            exchangeView?.sellButton.isEnabled = false
        } else {
            exchangeView?.buyButton.isEnabled = true
            exchangeView?.sellButton.isEnabled = true
        }
        
        if amountTextDouble > balanceDividedByPurchase {
            exchangeView?.buyButton.isEnabled = false
        }
        
        if amountTextInt > wallet {
            exchangeView?.sellButton.isEnabled = false
        }
        
        if sellPrice <= 0 {
            exchangeView?.sellButton.isEnabled = false
        }
        
    }
    
}


// ESTE CODIGO É MUITO MAIS ROBUSTO MAS EU PRECISO APRENDER MAIS PARA APLICALO
//protocol ExchangeViewModelDelegate: AnyObject {
//    func didTapBuyButton()
//    func didTapSellButton()
//    func didChangeAmountText(to text: String)
//}
//
//class ExchangeViewModel {
//
//    // MARK: - attributes
//    weak var delegate: ExchangeViewModelDelegate?
//    var exchangeModel: ExchangeModel?
//
//    // MARK: - init
//    init(exchangeModel: ExchangeModel?) {
//        self.exchangeModel = exchangeModel
//    }
//
//    // MARK: - setTargets
//    func setTargets(on buyButton: UIButton, sellButton: UIButton, amountLabel: UITextField) {
//        buyButton.addTarget(self, action: #selector(didTapBuyButton), for: .touchUpInside)
//        sellButton.addTarget(self, action: #selector(didTapSellButton), for: .touchUpInside)
//        amountLabel.addTarget(self, action: #selector(didChangeAmountText), for: .editingChanged)
//    }
//
//    // MARK: - didTapBuyButton
//    @objc func didTapBuyButton() {
//        delegate?.didTapBuyButton()
//    }
//
//    // MARK: - didTapSellButton
//    @objc func didTapSellButton() {
//        delegate?.didTapSellButton()
//    }
//
//    // MARK: - didChangeAmountText
//    @objc func didChangeAmountText(textField: UITextField) {
//        delegate?.didChangeAmountText(to: textField.text ?? "")
//    }
//
//    // MARK: - setupStackViewLabels
//    func setupStackViewLabels(currencyLabel: UILabel, variationLabel: UILabel, purchaseLabel: UILabel, saleLabel: UILabel) {
//        guard let currency = exchangeModel?.coin,
//              let currencyBuy = currency.buy,
//              let exchangeModel = exchangeModel,
//              let coinSigla = exchangeModel.coin.sigla else { return }
//
//        let coinName = exchangeModel.coin.name
//        let coinVariation = currency.variation
//        let currencySell = currency.sell ?? 0
//
//        currencyLabel.text = "\(coinSigla) - \(coinName)"
//        variationLabel.text = "\(String(format: "%.2f", coinVariation))%"
//        purchaseLabel.text = "Compra: R$ \(currencyBuy)"
//        saleLabel.text = "Venda: R$ \(currencySell)"
//
//        if currency.variation < 0 {
//            variationLabel.textColor = .variationRed()
//        } else if currency.variation > 0 {
//            variationLabel.textColor = .variationGreen()
//        } else {
//            variationLabel.textColor = .white
//        }
//    }
//
//}

