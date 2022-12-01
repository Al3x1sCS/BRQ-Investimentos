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
        
        return view
    }()
    
    var viewExchangeModel: ExchangeModel?
    var balanceModel: BalanceModel?
    var message: String?
    
    // MARK: - loadView
    override func loadView() {
        super.loadView()
        view = exchangeView
        view.backgroundColor = .black
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceModel = BalanceModel()
        setupNavigation(with: "Câmbio")
        exchangeView.setupView()
        
        exchangeView.amountLabel.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        exchangeView.sellButton.addTarget(self, action: #selector(sellTapped), for: .touchUpInside)
        exchangeView.buyButton.addTarget(self, action: #selector(buyTapped), for: .touchUpInside)
        
        exchangeView.amountLabel.delegate = self
    }
    
    // MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        setupKeyboardHiding()
        settingStackViewLabels()
        settingBalanceWalletLabels()
        setAmountLabelText()
        settingSellButtons()
        settingBuyButtons()
    }
    
    // MARK: setupKeyboardHiding
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    // MARK: settingSellButtons
    func settingSellButtons() {
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
    }
    
    // MARK: settingBuyButtons
    func settingBuyButtons() {
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
    
    // MARK: @objc sellTapped
    @objc func sellTapped(sender: UIButton) {
        guard let user = balanceModel,
              let currency = viewExchangeModel?.coin,
              let viewExchangeModel = viewExchangeModel,
              let coinSigla = viewExchangeModel.coin.sigla,
              let stringInputAmount = exchangeView.amountLabel.text,
              let intInputAmount = Int(stringInputAmount) else { return }
        
        let coinName = viewExchangeModel.coin.name
        
        user.transactions("sell", quantity: intInputAmount, coinSigla, currency)
        exchangeView.balanceLabel.text = "Saldo disponível: \(user.balanceLabelFormated)"
        exchangeView.cashierLabel.text = "\(String(user.userWallet[coinSigla] ?? 0)) \(coinName) em caixa"
        message = "Parabéns!\nVocê acabou de vender\n\(intInputAmount) \(coinSigla) - \(coinName),\n totalizando\n\(user.balanceLabelFormated)"
        buyAndSellNavigation(title: "Venda")
    }
    
    // MARK: @objc buyTapped
    @objc func buyTapped(sender: UIButton) {
        guard let user = balanceModel,
              let currency = viewExchangeModel?.coin,
              let viewExchangeModel = viewExchangeModel,
              let coinSigla = viewExchangeModel.coin.sigla,
              let stringInputAmount = exchangeView.amountLabel.text,
              let intInputAmount = Int(stringInputAmount) else { return }
        
        let coinName = viewExchangeModel.coin.name
        
        user.transactions("buy", quantity: intInputAmount, coinSigla, currency)
        exchangeView.balanceLabel.text = "Saldo disponível: \(user.balanceLabelFormated)"
        exchangeView.cashierLabel.text = "\(String(user.userWallet[coinSigla] ?? 0)) \(coinName) em caixa"
        message = "Parabéns!\nVocê acabou de\ncomprar \(intInputAmount) \(coinSigla) - \n\(coinName), totalizando\n\(user.balanceLabelFormated)"
        buyAndSellNavigation(title: "Compra")
    }
    
}

// MARK: - Extensions
extension ExchangeViewController {
    
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1.2
            view.frame.origin.y = newFrameY
        }

    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

// MARK: UIResponder
extension UIResponder {

    private struct Static {
        static weak var responder: UIResponder?
    }

    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}
