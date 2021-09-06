//
//  HeroDetailAssembler.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import Foundation

protocol HeroDetailAssembler {
    func resolve(hero: Hero) -> HeroDetailViewController
    func resolve() -> GetComicsUseCase
    func resolve() -> GetEventsUseCase
    func resolve() -> GetSeriesUseCase
}

extension HeroDetailAssembler {
    
    func resolve(hero: Hero) -> HeroDetailViewController {
        let heroDetailViewController = HeroDetailViewController()
        let router = HeroDetailRouter(viewController: heroDetailViewController)
        
        heroDetailViewController.presenter = HeroDetailPresenter<HeroDetailViewController>(
            getComicsUseCase: Assembler.shared.resolve(),
            getEventsUseCase: Assembler.shared.resolve(),
            getSeriesUseCase: Assembler.shared.resolve(),
            router: router,
            hero: hero
        )
        
        return heroDetailViewController
    }
    
    func resolve() -> GetComicsUseCase {
        return GetComics()
    }
    
    func resolve() -> GetEventsUseCase {
        return GetEvents()
    }
    
    func resolve() -> GetSeriesUseCase {
        return GetSeries()
    }
}
