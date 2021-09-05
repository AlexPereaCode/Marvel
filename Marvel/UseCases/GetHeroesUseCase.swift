//
//  GetHeroesUseCase.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation
import PromiseKit

protocol GetHeroesUseCase {
    func execute(offset: Int) -> Promise<CharacterDataWrapper>
}

struct GetHeroes: GetHeroesUseCase {
    func execute(offset: Int) -> Promise<CharacterDataWrapper> {
        return NetworkRequest<HeroSpecs, CharacterDataWrapper>.make(specs: .getHeroes(offset: offset))
    }
}
