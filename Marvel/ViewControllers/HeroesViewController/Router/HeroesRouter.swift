//
//  HeroesRouter.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import UIKit

enum HeroesError: String {
    case firstLoad = "The first charge of heroes has failed"
    case pagination = "Hero load paging has failed"
}

final class HeroesRouter {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pushHeroDetailViewController(heroId: Int) {
        print(heroId)
    }
    
    func showErrorAlert(type: HeroesError) {
        let alertController = UIAlertController(title: type.rawValue, message: "Try it again later", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        viewController?.present(alertController, animated: true, completion: nil)
    }
}
