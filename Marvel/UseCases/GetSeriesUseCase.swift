//
//  GetSeriesUseCase.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 6/9/21.
//

import Foundation
import PromiseKit

protocol GetSeriesUseCase {
    func execute(heroId: Int) -> Promise<ContentDataWrapper>
}

struct GetSeries: GetSeriesUseCase {
    func execute(heroId: Int) -> Promise<ContentDataWrapper> {
        return NetworkRequest<SeriesSpecs, ContentDataWrapper>.make(specs: .getSeries(heroId: heroId, timestamp: Credentials.timestamp()))
    }
}
