//
//  AppDelegate.swift
//  BRQ_Investimentos
//
//  Created by user on 17/10/22.
//

import UIKit
//TODO: - LIMPAR APP DELEGATE
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    //TODO: app delegate tem outras responsabilidades, vou atribuir a responsabilidade ao Coordinator.
    let navigation = UINavigationController(rootViewController: HomeViewController())
    let exchangeNavigation = UINavigationController(rootViewController: ExchangeViewController())
    let buyAndSellNavigation = UINavigationController(rootViewController: BuyAndSellViewController())
    
    //TODO: Essa responsabilidade é do SceneDelegate
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
        //TODO: Mover para View de cada uma das telas
        navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        exchangeNavigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        buyAndSellNavigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        //TODO: Coordinator? mas tambem tem que ver esse background black perdido
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .black
        window?.rootViewController = navigation
        
        //TODO: Preciso parar de depender de if de versão.
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            navigationBarAppearance.backgroundColor = UIColor.black
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance

            let tabBarApperance = UITabBarAppearance()
            tabBarApperance.configureWithOpaqueBackground()
            tabBarApperance.backgroundColor = UIColor.black
            UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
            UITabBar.appearance().standardAppearance = tabBarApperance
        }
        
        return true
    }

}
