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

    init(getHeroesUseCase: GetHeroesUseCase) {
        self.getHeroesUseCase = getHeroesUseCase
    }
    
    // MARK: - Life Cycle
    func viewDidLoad() {
        getHeroes()
        
    }
    
    private func getHeroes() {
        view?.showLoading()
        getHeroesUseCase.execute(offset: 0, limit: numberOfItemsForPage).done { characters in
            print("completed")
        } .ensure {
            self.view?.hideLoading()
        } .catch { error in
            // SHOW ERROR
        }
    }

}