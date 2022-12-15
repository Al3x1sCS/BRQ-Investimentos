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
    
    var exchangeModel: CoinModel?
    var balanceModel: BalanceViewModel?
    var exchangeViewModel: ExchangeViewModel?
    
    // MARK: - loadView
    override func loadView() {
        super.loadView()
        view = exchangeView
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceModel = BalanceViewModel()
        exchangeViewModel = ExchangeViewModel(exchangeView, exchangeModel!, navigationController)
        setupNavigation(with: "Câmbio")
        exchangeViewModel?.setTargets()
        exchangeView.setupView()
        exchangeView.amountLabel.delegate = self
    }
    
    // MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        SettingViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let exchangeModel = exchangeModel {
            exchangeViewModel?.exchangeModel = exchangeModel
        }
        
    }
    
    // MARK: - viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: setAmountLabelText
    private func SettingViewModel() {
        guard let currency = exchangeModel else { return }
        
        exchangeViewModel?.settingStackViewLabels(currency: currency)
        exchangeViewModel?.setAmountLabelText()
        exchangeViewModel?.updateButtonsState()
    }
    
}
