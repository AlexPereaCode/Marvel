//
//  HeroesPresenter.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation

final class HeroesPresenter<T: HeroesView>: BasePresenter<T> {
    
    private let numberOfItemsForPage: Int = 10
    private let getHeroesUseCase: GetHeroesUseCase
    private let router: HeroesRouter

    init(getHeroesUseCase: GetHeroesUseCase, router: HeroesRouter) {
        self.getHeroesUseCase = getHeroesUseCase
        self.router = router
    }
    
    // MARK: - Life Cycle
    func viewDidLoad() {
        getHeroes()
    }
    
    private func getHeroes() {
        getHeroesUseCase.execute(offset: 0, limit: numberOfItemsForPage).done { [weak self] characters in
            self?.view?.showHeroes(heroes: characters.data.heroes)
        } .ensure {
            self.view?.hideLoading()
        } .catch { error in
            // SHOW ERROR
        }
    }

}
