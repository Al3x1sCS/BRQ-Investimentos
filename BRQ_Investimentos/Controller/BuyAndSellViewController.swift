//
//  BuyAndSellViewController.swift
//  BRQ_Investimentos
//
//  Created by user on 25/10/22.
//

import UIKit

protocol BuyAndSellProtocol {
    func currency(user: BalanceViewModel)
}

class BuyAndSellViewController: BaseViewController {
    
    // MARK: - attributes
    lazy var buyAndSellView: BuyAndSellView = {
        var view = BRQ_Investimentos.BuyAndSellView()
        view.backgroundColor = .black
        return view
    }()
    
    var balanceModel: BalanceViewModel?
    var delegate: BuyAndSellProtocol?
    var message: String?
    
    // MARK: - loadView
    override func loadView() {
        super.loadView()
        view = buyAndSellView
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceModel = BalanceViewModel()
        buyAndSellView.setupView()
        titleVerified()
        setTargets()
    }
    
    public func setTargets() {
        buyAndSellView.homeButton.addTarget(self, action: #selector(homeTapped), for: .touchUpInside)
    }
    
    // MARK: titleVerified
    func titleVerified() {
        switch navigationItem.title {
        case "Venda":
            buyAndSellView.successLabel.text = message
        case "Compra":
            buyAndSellView.successLabel.text = message
        default:
            break
        }
    }
    
    // MARK: - @objc homeTapped
    @objc func homeTapped(sender: UIButton) {
        let balanceModel = BalanceViewModel()
        delegate?.currency(user: self.balanceModel ?? balanceModel)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
