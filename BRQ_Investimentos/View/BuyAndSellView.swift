//
//  BuyAndSellView.swift
//  BRQ_Investimentos
//
//  Created by user on 25/10/22.
//

import UIKit

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
            right: safeAreaLayoutGuide.rightAnchor,
            paddingTop: 175,
            paddingLeft: 24,
            paddingRight: 24,
            height: 190
        )
        
        homeButton.anchor (
            bottom: safeAreaLayoutGuide.bottomAnchor,
            right: safeAreaLayoutGuide.rightAnchor,
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
