//
//  HeroesAssembler.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation

protocol HeroesAssembler {
    func resolve() -> HeroesViewController
    func resolve() -> GetHeroesUseCase
}

extension HeroesAssembler {
    
    func resolve() -> HeroesViewController {
        let heroesViewController = HeroesViewController()
        let router = HeroesRouter(viewController: heroesViewController)
        heroesViewController.presenter = HeroesPresenter<HeroesViewController>(getHeroesUseCase: Assembler.shared.resolve(), router: router)
        
        return heroesViewController
    }
    
    func resolve() -> GetHeroesUseCase {
        return GetHeroes()
    }
}
