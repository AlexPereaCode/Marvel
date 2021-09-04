//
//  SceneDelegate.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: HeroesRouter().viewController)

        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

