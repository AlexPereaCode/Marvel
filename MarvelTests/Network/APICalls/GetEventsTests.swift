//
//  GetEventsTests.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import XCTest
import Alamofire
import PromiseKit
@testable import Marvel

class GetEventsTests: XCTestCase {
    
    var getEventsMock: GetEventsMock!
    var usecase: GetEventsUseCase!
    var expectation: XCTestExpectation!

    override func setUpWithError() throws {
        getEventsMock = GetEventsMock()
        usecase = GetEvents()
        expectation = expectation(description: "Loading Events")
    }

    override func tearDownWithError() throws {
        getEventsMock = nil
        usecase = nil
        expectation = nil
    }

    func testGetEventsApiErrorUseCaseReturnTheError() {
        getEventsMock.result = .init(error: HTTPResponse.noContent)
        
        var model: ContentDataWrapper?
                
        getEventsMock.execute(heroId: 897567).done { eventsData in
            model = eventsData
        } .ensure {
            self.expectation.fulfill()
        } .catch { _ in
            model = nil
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(model)
    }
    
    func testGetEventsApiSuccessUseCase() throws {
        let eventsData = try EventsMock().getEventsMock()
        
        getEventsMock.result = Promise<ContentDataWrapper>.value(eventsData)
        
        var model: ContentDataWrapper?
        
        getEventsMock.execute(heroId: 897567).done { eventsData in
            model = eventsData
        } .ensure {
            self.expectation.fulfill()
        } .catch { _ in
            model = nil
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(model)
    }
}
