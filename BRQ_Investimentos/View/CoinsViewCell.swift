//
//  CoinCell.swift
//  BRQ_Investimentos
//
//  Created by user on 18/10/22.
//

import UIKit
//TODO: mudar para o novo padrão de view que aprendi tambem3
class CoinsViewCell: UICollectionViewCell, ViewCodeProtocol {
    
    // MARK: - Labels
    lazy var coinLabel = LabelDefault(text: "", font: UIFont(name: "Arial-Black", size: 22.0) ?? UIFont.systemFont(ofSize: 22))
    
    lazy var variationLabel = LabelDefault(text: "", font: UIFont(name: "Arial", size: 20.0) ?? UIFont.systemFont(ofSize: 22), alignment: .right)

    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        //TODO: nao precisa ja esta no setupView()
        addictionalConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Hierachy
    func buildViewHierachy() {
        contentView.addSubview(coinLabel)
        contentView.addSubview(variationLabel)
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        coinLabel.anchor (
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: variationLabel.rightAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingBottom: 16,
            paddingRight: 163,
            width: 0,
            height: 0
        )
        
        variationLabel.anchor (
            top: topAnchor,
            left: coinLabel.leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: 21,
            paddingLeft: 180,
            paddingBottom: 20,
            paddingRight: 16,
            width: 0,
            height: 0
        )
    }
    
    // MARK: - addictional Configurations
    func addictionalConfiguration() {
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.cgColor
    }
    
}

