//
//  GetComicsUseCase.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import Foundation
import PromiseKit

protocol GetComicsUseCase {
    func execute(heroId: Int) -> Promise<ContentDataWrapper>
}

struct GetComics: GetComicsUseCase {
    func execute(heroId: Int) -> Promise<ContentDataWrapper> {
        return NetworkRequest<ComicsSpecs, ContentDataWrapper>.make(specs: .getComics(heroId: heroId, timestamp: Credentials.timestamp()))
    }
}
