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
        setupNavigation(with: "Moedas")
        return view
    }()

    var exchangeVC = ExchangeViewController()
    var buyAndSellVC = BuyAndSellViewController()
    var homeViewModel: HomeViewModel?
    var homeCoordinator: HomeCoordinator?
    
    // MARK: - loadView
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCoordinator = HomeCoordinator(navigationController: self.navigationController!)
        setDelegates()
    }
    
    // MARK: - viewDidAppear
    override func viewWillAppear(_ animated: Bool) {
        homeViewModel = HomeViewModel(delegate: self)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
    func setDelegates() {
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
        buyAndSellVC.delegate = self
    }
    
}

// MARK: - CollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.homeViewModel?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCell", for: indexPath) as! CoinsViewCell
        
        cell.coinLabel.text = homeViewModel?.coins[indexPath.row].sigla

        if let variation = homeViewModel?.coins[indexPath.row].variation {
            cell.variationLabel.text = "\(String(format: "%.2f", variation))%"
        }
        
        cell.variationLabel.textColor = homeViewModel?.variationColor(indexPath: indexPath.row)
        cell.variationImageView.image = homeViewModel?.variationImage(indexPath: indexPath.row)

        
        return cell
    }
    
}

// MARK: - CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let coin = homeViewModel?.coins[indexPath.row] {
            exchangeVC.exchangeModel = CoinModel(currency: coin)
        }
        homeCoordinator?.navigateToExchangeViewController(exchangeVC)
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
    
    func currency(user: BalanceViewModel) {
        exchangeVC.balanceModel = user
    }
    
}
