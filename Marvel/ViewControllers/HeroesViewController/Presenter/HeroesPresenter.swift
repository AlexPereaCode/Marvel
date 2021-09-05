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
    private var heroes = [Hero]()
    private var filteredHeroes = [Hero]()

    init(getHeroesUseCase: GetHeroesUseCase, router: HeroesRouter) {
        self.getHeroesUseCase = getHeroesUseCase
        self.router = router
    }
    
    // MARK: - Life Cycle
    func viewDidLoad() {
        getHeroes()
    }
    
    // MARK: - Public Methods
    func updateSearchResults(searchText: String) {
        if searchText == "" {
            view?.showHeroes(heroes: heroes)
            return
        }
        filteredHeroes = heroes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        view?.showHeroes(heroes: filteredHeroes)
    }
        
    // MARK: - Private Methods
    private func getHeroes() {
        getHeroesUseCase.execute(offset: 0, limit: numberOfItemsForPage).done { [weak self] characters in
            self?.heroes = characters.data.heroes
            self?.view?.showHeroes(heroes: characters.data.heroes)
        } .ensure {
            self.view?.hideLoading()
        } .catch { error in
            // SHOW ERROR
        }
    }
}
