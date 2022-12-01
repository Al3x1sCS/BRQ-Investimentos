//
//  ExchangeView.swift
//  BRQ_Investimentos
//
//  Created by user on 20/10/22.
//

import UIKit

class ExchangeView: UIView, ViewCodeProtocol {
    
    // MARK: - StackView
    lazy var stackView = UIStackView()
    
    // MARK: - LabelDefault
    lazy var currencyLabel = LabelDefault(text: "", font: UIFont(name: "Arial-Black", size: 22.0) ?? UIFont.systemFont(ofSize: 22))
    
    lazy var variationLabel = LabelDefault(text: "", font: UIFont(name: "Arial", size: 20.0) ?? UIFont.systemFont(ofSize: 22))
    
    lazy var purchaseLabel = LabelDefault(text: "")
    
    lazy var saleLabel = LabelDefault(text: "")
    
    lazy var balanceLabel = LabelDefault(text: "", font: UIFont(name: "Arial", size: 24.0) ?? UIFont.systemFont(ofSize: 22))
    
    lazy var cashierLabel = LabelDefault(text: "", font: UIFont(name: "Arial", size: 24.0) ?? UIFont.systemFont(ofSize: 22))
    
    // MARK: - Text Field
    lazy var amountLabel = TextFieldDefault(placeholder: "Quantidade")
    
    // MARK: - Buttons
    lazy var sellButton = ButtonDefault(title: "VENDER")
    
    lazy var buyButton = ButtonDefault(title: "COMPRAR")
    
    // MARK: - View Hierachy
    func buildViewHierachy() {
        addSubview(stackView)
        stackView.addSubview(currencyLabel)
        stackView.addSubview(variationLabel)
        stackView.addSubview(purchaseLabel)
        stackView.addSubview(saleLabel)
        addSubview(balanceLabel)
        addSubview(cashierLabel)
        addSubview(amountLabel)
        addSubview(sellButton)
        addSubview(buyButton)
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        
        stackView.anchor (
            top: safeAreaLayoutGuide.topAnchor,
            left: safeAreaLayoutGuide.leftAnchor,
            bottom: nil,
            right: safeAreaLayoutGuide.rightAnchor,
            paddingTop: 24,
            paddingLeft: 24,
            paddingBottom: 0,
            paddingRight: 24,
            width: 0,
            height: 171
        )
        
        currencyLabel.anchor (
            top: stackView.topAnchor,
            left: stackView.leftAnchor,
            bottom: nil,
            right: stackView.rightAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingBottom: 0,
            paddingRight: 16,
            width: 0,
            height: 0
        )
        
        variationLabel.anchor (
            top: currencyLabel.bottomAnchor,
            left: stackView.leftAnchor,
            bottom: nil,
            right: stackView.rightAnchor,
            paddingTop: 15,
            paddingLeft: 16,
            paddingBottom: 0,
            paddingRight: 16,
            width: 0,
            height: 22
        )
        
        purchaseLabel.anchor (
            top: variationLabel.bottomAnchor,
            left: stackView.leftAnchor,
            bottom: nil,
            right: stackView.rightAnchor,
            paddingTop: 19,
            paddingLeft: 16,
            paddingBottom: 0,
            paddingRight: 163,
            width: 148,
            height: 17
        )
        
        saleLabel.anchor (
            top: purchaseLabel.bottomAnchor,
            left: stackView.leftAnchor,
            bottom: stackView.bottomAnchor,
            right: stackView.rightAnchor,
            paddingTop: 15,
            paddingLeft: 16,
            paddingBottom: 20,
            paddingRight: 163,
            width: 148,
            height: 17
        )
        
        balanceLabel.anchor (
            top: stackView.bottomAnchor,
            left: safeAreaLayoutGuide.leftAnchor,
            bottom: nil, right: safeAreaLayoutGuide.rightAnchor,
            paddingTop: 32,
            paddingLeft: 24,
            paddingBottom: 0,
            paddingRight: 24,
            width: 0,
            height: 0
        )
        
        cashierLabel.anchor (
            top: balanceLabel.bottomAnchor,
            left: safeAreaLayoutGuide.leftAnchor,
            bottom: nil,
            right: safeAreaLayoutGuide.rightAnchor,
            paddingTop: 24,
            paddingLeft: 24,
            paddingBottom: 0,
            paddingRight: 24,
            width: 0,
            height: 0
        )
        
        amountLabel.anchor (
            top: cashierLabel.bottomAnchor,
            left: safeAreaLayoutGuide.leftAnchor,
            bottom: nil,
            right: safeAreaLayoutGuide.rightAnchor,
            paddingTop: 32,
            paddingLeft: 24,
            paddingBottom: 0,
            paddingRight: 24,
            width: 0,
            height: 54
        )
        
        sellButton.anchor (
            top: nil,
            left: safeAreaLayoutGuide.leftAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            right: nil,
            paddingTop: 0,
            paddingLeft: 24,
            paddingBottom: 40,
            paddingRight: 0,
            width: 151,
            height: 43
        )
        
        buyButton.anchor (
            top: nil,
            left: nil,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            right: safeAreaLayoutGuide.rightAnchor,
            paddingTop: 0,
            paddingLeft: 25,
            paddingBottom: 40,
            paddingRight: 24,
            width: 151,
            height: 43
        )
    }
    
    // MARK: - addictional Configurations
    func addictionalConfiguration() {
        stackView.backgroundColor = .black
        stackView.layer.cornerRadius = 15
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.white.cgColor
    }
    
}
