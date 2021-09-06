//
//  GetEventsUseCase.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 6/9/21.
//

import Foundation
import PromiseKit

protocol GetEventsUseCase {
    func execute(heroId: Int) -> Promise<ContentDataWrapper>
}

struct GetEvents: GetEventsUseCase {
    func execute(heroId: Int) -> Promise<ContentDataWrapper> {
        return NetworkRequest<EventSpecs, ContentDataWrapper>.make(specs: .getEvents(heroId: heroId))
    }
}
