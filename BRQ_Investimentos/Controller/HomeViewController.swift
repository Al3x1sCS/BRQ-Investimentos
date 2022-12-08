//
//  HomeController.swift
//  BRQ_Investimentos
//
//  Created by user on 18/10/22.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - attributes
    lazy var homeView: HomeView = {
        var view = BRQ_Investimentos.HomeView()
        
        return view
    }()

    var exchangeVC = ExchangeViewController()
    var buyAndSellVC = BuyAndSellViewController()
    
    var viewHomeModel: HomeModel?
    var viewExchangeModel: ExchangeModel?
    
    // MARK: - loadView
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: sera mesmo que é responsabilidade da controller atribuir um nome a tela? verificar a possibilidade de passar isso pra view.
        setupNavigation(with: "Moedas")
        homeView.setupView()
        
        //TODO: estudar mais pra saber se esta correto esses delegates no viewDidLoad
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
        buyAndSellVC.delegate = self
    }
    
    // MARK: - viewDidAppear
    override func viewWillAppear(_ animated: Bool) {
        viewHomeModel = HomeModel(delegate: self)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    //TODO: verificar se é responsabilidade da view model
    // MARK: variationColor
    private func variationColor(indexPath: Int) -> UIColor {
        
        if let variation = self.viewHomeModel?.getVariation(index: indexPath) {
            
            if variation > 0 {
                return .variationGreen()
            } else if variation < 0 {
                return .variationRed()
            } else {
                return UIColor.white
            }
        }
        return UIColor()
    }
    
}

// MARK: - CollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewHomeModel?.coins.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCell", for: indexPath) as! CoinsViewCell
        
        cell.coinLabel.text = viewHomeModel?.coins[indexPath.row].sigla
        //TODO: verificar a posibilidade disso ser responsa da viewmodel
        if let variation = viewHomeModel?.coins[indexPath.row].variation {
            cell.variationLabel.text = "\(String(format: "%.2f", variation))%"
        }
        
        cell.variationLabel.textColor = variationColor(indexPath: indexPath.row)
        
        return cell
    }
    
}

// MARK: - CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let coin = viewHomeModel?.coins[indexPath.row] {
            exchangeVC.viewExchangeModel = ExchangeModel(coin: coin)
        }
        //TODO: verificar se tem que chamar o coordinator aki
        self.navigationController?.pushViewController(exchangeVC, animated: true)
    }
    
}

// MARK: - HomeViewControllerDelegate
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width - 24, height: 63)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 24, left: -24, bottom: 24, right: -24)
    }
    
}

// MARK: Protocols
extension HomeViewController: HomeModelProtocol {
    func updateView() {
        homeView.collectionView.reloadData()
    }
    
}

extension HomeViewController: BuyAndSellProtocol {
    
    func currency(user: BalanceModel) {
        exchangeVC.balanceModel = user
    }
    
}
