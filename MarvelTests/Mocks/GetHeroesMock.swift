//
//  GetHeroesMock.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import Foundation
import PromiseKit
@testable import Marvel

class GetHeroesMock: GetHeroesUseCase {
    
    var result: Promise<CharacterDataWrapper> = Promise<CharacterDataWrapper>(error: HTTPResponse.noContent)
    
    func execute(offset: Int) -> Promise<CharacterDataWrapper> {
        return result
    }
}
