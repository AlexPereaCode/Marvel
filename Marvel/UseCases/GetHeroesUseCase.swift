//
//  GetHeroesUseCase.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation
import PromiseKit

protocol GetHeroesUseCase {
    func execute(offset: Int, limit: Int) -> Promise<Characters>
}

struct GetHeroes: GetHeroesUseCase {
    func execute(offset: Int, limit: Int) -> Promise<Characters> {
        return NetworkRequest<HeroesSpecs, Characters>.make(specs: .getHeroes(offset: offset, limit: limit))
    }
}
