//
//  GetSeriesTests.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import XCTest
import Alamofire
import PromiseKit
@testable import Marvel

class GetSeriesTests: XCTestCase {

    var getSeriesMock: GetSeriesMock!
    var usecase: GetSeriesUseCase!
    var expectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        getSeriesMock = GetSeriesMock()
        usecase = GetSeries()
        expectation = expectation(description: "Loading Series")
    }

    override func tearDownWithError() throws {
        getSeriesMock = nil
        usecase = nil
        expectation = nil
    }

    func testGetSeriesApiErrorUseCaseReturnTheError() {
        getSeriesMock.result = .init(error: HTTPResponse.noContent)
        
        var model: ContentDataWrapper?
                
        getSeriesMock.execute(heroId: 465354).done { seriesData in
            model = seriesData
        } .ensure {
            self.expectation.fulfill()
        } .catch { _ in
            model = nil
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(model)
    }

    func testGetSeriesApiSuccessUseCase() throws {
        let seriesData = try SeriesMock().getSeriesMock()
        
        getSeriesMock.result = Promise<ContentDataWrapper>.value(seriesData)
        
        var model: ContentDataWrapper?
        
        getSeriesMock.execute(heroId: 465354).done { seriesData in
            model = seriesData
        } .ensure {
            self.expectation.fulfill()
        } .catch { _ in
            model = nil
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(model)
    }
}
