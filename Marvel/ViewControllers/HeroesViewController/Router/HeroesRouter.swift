//
//  HeroesRouter.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import UIKit

class HeroesRouter {
    
    var viewController: UIViewController {
        return getHeroesViewController()
    }
    
    private func getHeroesViewController() -> UIViewController {
        let homeViewController: HeroesViewController = Assembler.shared.resolve()
        return homeViewController
    }
}
