//
//  AppRooter.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import UIKit

final class AppRouter {
    private(set) var window: UIWindow

    init(window: UIWindow = UIWindow()) {
        self.window = window
    }
    
    func showInitialViewController() {
        let rootViewController: HeroesViewController = Assembler.shared.resolve()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
