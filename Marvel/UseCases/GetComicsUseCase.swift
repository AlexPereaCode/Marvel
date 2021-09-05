//
//  GetComicsUseCase.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import Foundation
import PromiseKit

protocol GetComicsUseCase {
    func execute(heroId: Int) -> Promise<ComicDataWrapper>
}

struct GetComics: GetComicsUseCase {
    func execute(heroId: Int) -> Promise<ComicDataWrapper> {
        return NetworkRequest<ComicSpecs, ComicDataWrapper>.make(specs: .getComics(heroId: heroId))
    }
}
