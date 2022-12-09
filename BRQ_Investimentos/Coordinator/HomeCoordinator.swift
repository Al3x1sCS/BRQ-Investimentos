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
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
