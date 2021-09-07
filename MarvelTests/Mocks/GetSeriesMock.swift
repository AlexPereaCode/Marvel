//
//  GetSeriesMock.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import Foundation
import PromiseKit
@testable import Marvel

class GetSeriesMock: GetSeriesUseCase {
    
    var result: Promise<ContentDataWrapper> = Promise<ContentDataWrapper>(error: HTTPResponse.noContent)
    
    func execute(heroId: Int) -> Promise<ContentDataWrapper> {
        return result
    }
}
