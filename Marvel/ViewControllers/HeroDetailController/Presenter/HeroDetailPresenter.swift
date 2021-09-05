//
//  HeroDetailPresenter.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import Foundation

final class HeroDetailPresenter<T: HeroDetailView>: BasePresenter<T> {
    
    private let getComicsUseCase: GetComicsUseCase
    private let router: HeroDetailRouter
    private let hero: Hero
    
    init(getComicsUseCase: GetComicsUseCase, router: HeroDetailRouter, hero: Hero) {
        self.getComicsUseCase = getComicsUseCase
        self.router = router
        self.hero = hero
    }
    
    // MARK: - Life Cycle
    func viewDidLoad() {
        view?.showHeader(hero: hero)
        getComics()
    }
    
    // MARK: - Private Methods
    private func getComics() {
        getComicsUseCase.execute(heroId: hero.id).done { [weak self] result in
            var urls = [String]()
            result.data.comics.forEach { urls.append($0.thumbnail.url) }
            self?.view?.showComics(comicsURL: urls)
        } .ensure {
            self.view?.hideLoading()
        } .catch { error in
            
        }
    }
}
