//
//  ExchangeViewController.swift
//  BRQ_Investimentos
//
//  Created by user on 20/10/22.
//

import UIKit

class ExchangeViewController: BaseViewController {
    
    // MARK: - attributes
    lazy var exchangeView: ExchangeView = {
        var view = BRQ_Investimentos.ExchangeView()
        view.backgroundColor = .black
        return view
    }()
    
    var viewExchangeModel: ExchangeModel?
    var balanceModel: BalanceViewModel?
    var message: String?
    
    // MARK: - loadView
    override func loadView() {
        super.loadView()
        view = exchangeView
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceModel = BalanceViewModel()
        setupNavigation(with: "Câmbio")
        exchangeView.setupView()
        setTargets()
        
        exchangeView.amountLabel.delegate = self
    }
    
    // MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        settingStackViewLabels()
        settingBalanceWalletLabels()
        setAmountLabelText()
        setupButtons()
    }
    
    // MARK: - viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //TODO: - verificar se todas as func vão virar viewModel, ou seja, devo estudar mais sobre a responsa da viewModel
    
    private func setTargets() {
        exchangeView.sellButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        exchangeView.buyButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        exchangeView.amountLabel.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // MARK: buyAndSellNavigation
    private func buyAndSellNavigation(title: String) {
        let viewController = BuyAndSellViewController()
        viewController.setupNavigation(with: title)
        viewController.message = message
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: setAmountLabelText
    private func setAmountLabelText() {
        exchangeView.amountLabel.text = ""
    }
    
    // MARK: settingStackViewLabels
    func settingStackViewLabels() {
        guard let currency = viewExchangeModel?.coin,
              let currencyBuy = currency.buy,
              let viewExchangeModel = viewExchangeModel,
              let coinSigla = viewExchangeModel.coin.sigla else { return }
        
        let coinName = viewExchangeModel.coin.name
        let coinVariation = currency.variation
        let currencySell = currency.sell ?? 0
        
        exchangeView.currencyLabel.text = "\(coinSigla) - \(coinName)"
        exchangeView.variationLabel.text = "\(String(format: "%.2f", coinVariation))%"
        exchangeView.purchaseLabel.text = "Compra: R$ \(currencyBuy)"
        exchangeView.saleLabel.text = "Venda: R$ \(currencySell)"
        
        if currency.variation < 0 {
            exchangeView.variationLabel.textColor = .variationRed()
        } else if currency.variation > 0 {
            exchangeView.variationLabel.textColor = .variationGreen()
        } else {
            exchangeView.variationLabel.textColor = .white
        }
        
    }
    
    // MARK: settingBalanceWalletLabels
    func settingBalanceWalletLabels() {
        guard let user = balanceModel,
              let viewExchangeModel = viewExchangeModel,
              let coinSigla = viewExchangeModel.coin.sigla,
              let userCoinValue = user.userWallet[coinSigla] else { return }
        
        let coinName = viewExchangeModel.coin.name
        
        exchangeView.balanceLabel.text = "Saldo disponível: \(user.balanceLabelFormated)"
        exchangeView.cashierLabel.text = "\(userCoinValue) \(coinName) em caixa"
    }
    
    func setupButtons() {
        guard let user = balanceModel,
              let viewExchangeModel = viewExchangeModel,
              let coinSigla = viewExchangeModel.coin.sigla,
              let wallet = user.userWallet[coinSigla] else { return }

        let sellButton = exchangeView.sellButton
        sellButton.isEnabled = false

        guard wallet > 0 else {
            sellButton.isEnabled = false
            return
        }

        let buyButton = exchangeView.buyButton
        buyButton.isEnabled = false

        guard balanceModel?.balance ?? 0 > 0 else {
            buyButton.isEnabled = false
            return
        }
    }
    
    // MARK: - @objc textFieldDidChange
    @objc private func textFieldDidChange(textField: UITextField) {
        guard let balance = balanceModel,
              let coinBuy = viewExchangeModel?.coin.buy,
              let amountLabelText = exchangeView.amountLabel.text,
              let amountTextInt = Int(amountLabelText),
              let coinSigla = viewExchangeModel?.coin.sigla,
              let wallet = balance.userWallet[coinSigla],
              let amountTextDouble = Double(amountLabelText) else { return }
        
        let balanceDividedByPurchase = (balance.balance ) / (coinBuy)
        let sellPrice = viewExchangeModel?.coin.sell ?? 0
        
        if amountLabelText == "" {
            exchangeView.buyButton.isEnabled = false
            exchangeView.sellButton.isEnabled = false
        } else {
            exchangeView.buyButton.isEnabled = true
            exchangeView.sellButton.isEnabled = true
        }
        
        if amountTextDouble > balanceDividedByPurchase {
            exchangeView.buyButton.isEnabled = false
        }
        
        if amountTextInt > wallet {
            exchangeView.sellButton.isEnabled = false
        }
        
        if sellPrice <= 0 {
            exchangeView.sellButton.isEnabled = false
        }
        
    }
    
    @objc func buttonTapped(sender: UIButton) {
        guard let user = balanceModel,
              let currency = viewExchangeModel?.coin,
              let coinSell = currency.sell,
              let viewExchangeModel = viewExchangeModel,
              let coinSigla = viewExchangeModel.coin.sigla,
              let stringInputAmount = exchangeView.amountLabel.text,
              let intInputAmount = Int(stringInputAmount) else { return }

        let coinName = viewExchangeModel.coin.name
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        let total = String(formatter.string(from: NSNumber(value: (coinSell)*(Double(intInputAmount))))!)

        switch sender {
            case exchangeView.sellButton:
                user.transactions("sell", quantity: intInputAmount, coinSigla, currency)
                message = "Parabéns!\nVocê acabou de vender\n\(intInputAmount) \(coinSigla) - \(coinName),\n totalizando\n\(total)"
                buyAndSellNavigation(title: "Venda")
            case exchangeView.buyButton:
                user.transactions("buy", quantity: intInputAmount, coinSigla, currency)
                message = "Parabéns!\nVocê acabou de\ncomprar \(intInputAmount) \(coinSigla) - \n\(coinName), totalizando\n\(total)"
                buyAndSellNavigation(title: "Compra")
            default:
                break
        }

        exchangeView.balanceLabel.text = "Saldo disponível: \(user.balanceLabelFormated)"
        exchangeView.cashierLabel.text = "\(String(user.userWallet[coinSigla] ?? 0)) \(coinName) em caixa"
    }
    
}
