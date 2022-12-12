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
    var viewExchangeModel: ExchangeModel?
    var balanceModel: BalanceViewModel?
    var message: String?
    
    // MARK: - Initialization
    init(viewExchangeModel: ExchangeModel?, balanceModel: BalanceViewModel?, message: String?) {
        self.viewExchangeModel = viewExchangeModel
        self.balanceModel = balanceModel
        self.message = message
    }
    
    // MARK: - setTargets
    func setTargets() {
        // Implementar a funcionalidade de adicionar targets aos botões e text field
    }
    
    // MARK: - buyAndSellNavigation
    func buyAndSellNavigation(title: String) {
        // Implementar a funcionalidade de navegação para a tela de compra e venda
    }
    
    // MARK: - setAmountLabelText
    func setAmountLabelText() {
        // Implementar a funcionalidade de definir o texto do amountLabel
    }
    
    // MARK: - settingStackViewLabels
    func settingStackViewLabels() {
        // Implementar a funcionalidade de definir os labels da stack view
    }
    
    // MARK: - settingBalanceWalletLabels
    func settingBalanceWalletLabels() {
        // Implementar a funcionalidade de definir os labels do balance wallet
    }
    
    // MARK: - setupButtons
    func setupButtons() {
        // Implementar a funcionalidade de configurar os botões
    }
    
    // MARK: - handleShowKeyboard
    func handleShowKeyboard(notification: Notification) {
        // Implementar a funcionalidade de lidar com a exibição do teclado
    }
    
    // MARK: - handleHideKeyboard
    func handleHideKeyboard(notification: Notification) {
        // Implementar a funcionalidade de lidar com a ocultação do teclado
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

