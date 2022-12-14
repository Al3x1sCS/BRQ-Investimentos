//
//  SceneDelegate.swift
//  BRQ_Investimentos
//
//  Created by user on 17/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var keyboardManager: KeyboardManager?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        guard let winScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: winScene)
        window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        
        let coordinator = HomeCoordinator(navigationController: navigationController)
        coordinator.start()
        
        keyboardManager = KeyboardManager()
        keyboardManager?.window = window
    }
    
    deinit {
        keyboardManager = nil
    }
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension UIResponder {

    private struct Static {
        static weak var responder: UIResponder?
    }

    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}
