//
//  BuyAndSellView.swift
//  BRQ_Investimentos
//
//  Created by user on 25/10/22.
//

import UIKit
//TODO: mudar para o novo padrão de view que aprendi tambem4
class BuyAndSellView: UIView, ViewCodeProtocol {
    
    // MARK: - Label
    lazy var successLabel = LabelDefault(text: "", font: UIFont(name: "Helvetica", size: 30.0) ?? UIFont.systemFont(ofSize: 30), alignment: .center)
    
    // MARK: - Button
    lazy var homeButton = ButtonDefault(title: "HOME")
    
    // MARK: - View Hierachy
    func buildViewHierachy() {
        addSubview(successLabel)
        addSubview(homeButton)
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        successLabel.anchor (
            top: safeAreaLayoutGuide.topAnchor,
            left: safeAreaLayoutGuide.leftAnchor,
            bottom: nil,
            right: safeAreaLayoutGuide.rightAnchor,
            paddingTop: 175,
            paddingLeft: 24,
            paddingBottom: 0,
            paddingRight: 24,
            width: 0,
            height: 190
        )
        
        homeButton.anchor (
            top: nil,
            left: nil,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            right: safeAreaLayoutGuide.rightAnchor,
            paddingTop: 0,
            paddingLeft: 120,
            paddingBottom: 40,
            paddingRight: 120,
            width: 151,
            height: 43
        )
    }
    
    // MARK: - addictional Configurations
    func addictionalConfiguration() {
        successLabel.adjustsFontForContentSizeCategory = true
        successLabel.numberOfLines = 0
        successLabel.textColor = .variationGreen()
    }
    
}
