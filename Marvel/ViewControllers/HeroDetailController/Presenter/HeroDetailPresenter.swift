//
//  HeroDetailPresenter.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import Foundation
import PromiseKit

final class HeroDetailPresenter<T: HeroDetailView>: BasePresenter<T> {
    
    // MARK: - Properties
    private let getComicsUseCase: GetComicsUseCase
    private let getEventsUseCase: GetEventsUseCase
    private let getSeriesUseCase: GetSeriesUseCase
    private let router: HeroDetailRouter
    private let hero: Hero
    
    // MARK: - Initialization
    init(getComicsUseCase: GetComicsUseCase,
         getEventsUseCase: GetEventsUseCase,
         getSeriesUseCase: GetSeriesUseCase,
         router: HeroDetailRouter,
         hero: Hero)
    {
        self.getComicsUseCase = getComicsUseCase
        self.getEventsUseCase = getEventsUseCase
        self.getSeriesUseCase = getSeriesUseCase
        self.router = router
        self.hero = hero
    }
    
    // MARK: - Life Cycle
    func viewDidLoad() {
        view?.showContent(content: DetailHeroModel(hero: hero, comics: [], events: [], series: []))
        getContent()
    }
    
    // MARK: - Private Methods
    private func getContent() {
        when(fulfilled:
            getComicsUseCase.execute(heroId: hero.id),
            getEventsUseCase.execute(heroId: hero.id),
            getSeriesUseCase.execute(heroId: hero.id)).done { [weak self] comics, events, series in
                
                guard let hero = self?.hero else { return }
                let content = DetailHeroModel(hero: hero,
                                              comics: comics.data.getImagesURL,
                                              events: events.data.getImagesURL,
                                              series: series.data.getImagesURL)
                
                self?.view?.showContent(content: content)
            }.ensure {
                self.view?.hideLoading()
            }.cauterize()
    }

}
