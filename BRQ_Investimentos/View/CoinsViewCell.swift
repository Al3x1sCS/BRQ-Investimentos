//
//  CoinsViewCell.swift
//  BRQ_Investimentos
//
//  Created by user on 18/10/22.
//

import UIKit

class CoinsViewCell: UICollectionViewCell, ViewCodeProtocol {
    
    // MARK: - Labels
    lazy var coinLabel = LabelDefault(text: "", font: UIFont(name: "Arial-Black", size: 22.0) ?? UIFont.systemFont(ofSize: 22))
    
    lazy var variationLabel = LabelDefault(text: "", font: UIFont(name: "Arial", size: 20.0) ?? UIFont.systemFont(ofSize: 22), alignment: .right)
    
    lazy var variationImageView = UIImageView()

    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Hierachy
    func buildViewHierachy() {
        contentView.addSubview(coinLabel)
        contentView.addSubview(variationLabel)
        contentView.addSubview(variationImageView)
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        coinLabel.anchor (
            top: self.topAnchor,
            left: self.leftAnchor,
            bottom: self.bottomAnchor,
            right: variationLabel.leftAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingBottom: 16,
            paddingRight: 16,
            width: 0,
            height: 0
        )
        
        variationLabel.anchor (
            top: self.topAnchor,
            left: coinLabel.rightAnchor,
            bottom: self.bottomAnchor,
            right: variationImageView.leftAnchor,
            paddingTop: 21,
            paddingLeft: 16,
            paddingBottom: 20,
            paddingRight: 16,
            width: 100,
            height: 0
        )
        
        variationImageView.anchor (
            top: self.topAnchor,
            left: variationLabel.rightAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: 21,
            paddingLeft: 16,
            paddingBottom: 20,
            paddingRight: 16,
            width: 20,
            height: 20
        )
    }
    
    // MARK: - addictional Configurations
    func addictionalConfiguration() {
        variationImageView.image = UIImage(named: "BRQ_Investimentos_Logo")
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.cgColor
    }
    
}

