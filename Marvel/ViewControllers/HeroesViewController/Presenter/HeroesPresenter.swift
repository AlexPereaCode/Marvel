//
//  HeroesPresenter.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation

final class HeroesPresenter<T: HeroesView>: BasePresenter<T> {
    
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
    
    func needToLoadMore(currentIndex: Int) -> Bool {
        return !heroes.isEmpty && currentIndex >= heroes.count - 1
    }
    
    func loadMoreUsers() {
        view?.showFooterActivityIndicator()
        getHeroesUseCase.execute(offset: heroes.count).done { [weak self] characters in
            self?.heroes.append(contentsOf: characters.data.heroes)
            self?.view?.appendHeroes(heroes: characters.data.heroes)
        } .ensure {
            self.view?.hideFooterActivityIndicator()
        } .catch { error in
            // SHOW ERROR
        }
    }
    
    func refreshData() {
        if filteredHeroes.isEmpty {
            heroes = [Hero]()
            getHeroes()
            return
        }
        view?.endRefreshing()
    }
        
    // MARK: - Private Methods
    private func getHeroes() {
        getHeroesUseCase.execute(offset: 0).done { [weak self] characters in
            self?.heroes = characters.data.heroes
            self?.view?.showHeroes(heroes: self?.heroes ?? [Hero]())
        } .ensure {
            self.view?.hideLoading()
            self.view?.endRefreshing()
        } .catch { error in
            // SHOW ERROR
        }
    }
}
