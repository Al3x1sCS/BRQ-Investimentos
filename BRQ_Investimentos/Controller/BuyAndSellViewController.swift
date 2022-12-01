//
//  BuyAndSellViewController.swift
//  BRQ_Investimentos
//
//  Created by user on 25/10/22.
//

import UIKit

protocol BuyAndSellProtocol {
    func currency(user: BalanceModel)
}

class BuyAndSellViewController: BaseViewController {
    
    // MARK: - attributes
    lazy var buyAndSellView: BuyAndSellView = {
        var view = BRQ_Investimentos.BuyAndSellView()
    
        return view
    }()
    
    var balanceModel: BalanceModel?
    var message: String?
    
    var delegate: BuyAndSellProtocol?
    
    // MARK: - loadView
    override func loadView() {
        super.loadView()
        view = buyAndSellView
        view.backgroundColor = .black
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceModel = BalanceModel()
        buyAndSellView.setupView()
        titleVerified()
        buyAndSellView.homeButton.addTarget(self, action: #selector(homeTapped), for: .touchUpInside)
    }
    
    // MARK: titleVerified
    func titleVerified() {
        
        if navigationItem.title == "Venda" {
            buyAndSellView.successLabel.text = message
        }
        
        if navigationItem.title == "Compra" {
            buyAndSellView.successLabel.text = message
        }
        
    }
    
    // MARK: - @objc homeTapped
    @objc func homeTapped(sender: UIButton) {
        let balanceModel = BalanceModel()
        delegate?.currency(user: self.balanceModel ?? balanceModel)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
