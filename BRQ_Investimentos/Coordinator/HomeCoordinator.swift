//
//  HomeCoordinator.swift
//  BRQ_Investimentos
//
//  Created by user on 09/12/22.
//

import Foundation
import UIKit

class  HomeCoordinator : Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeViewController()
        
        viewController.homeCoordinator = self
        
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func navigateToExchangeViewController(_ exchangeViewController: ExchangeViewController) {
        self.navigationController.pushViewController(exchangeViewController, animated: true)
    }
}
