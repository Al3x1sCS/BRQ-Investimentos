//
//  HomeView.swift
//  BRQ_Investimentos
//
//  Created by user on 18/10/22.
//

import UIKit

class HomeView: UIView , ViewCodeProtocol {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Hierachy
    func buildViewHierachy() {
        addSubview(collectionView)
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        collectionView.anchor (
            top: safeAreaLayoutGuide.topAnchor,
            left: safeAreaLayoutGuide.leftAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            right: safeAreaLayoutGuide.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0,
            width: 0,
            height: 0
        )
    }
    
    // MARK: - addictional Configurations
    func addictionalConfiguration() {
        collectionView.backgroundColor = .black
        collectionView.register(CoinsViewCell.self, forCellWithReuseIdentifier: "CoinCell")
    }
    
}
