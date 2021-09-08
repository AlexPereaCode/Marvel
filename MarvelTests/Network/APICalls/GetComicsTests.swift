//
//  GetComicsTests.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import XCTest
import Alamofire
import PromiseKit
@testable import Marvel

class GetComicsTests: XCTestCase {
    
    var getComicsMock: GetComicsMock!
    var usecase: GetComicsUseCase!
    var expectation: XCTestExpectation!

    override func setUpWithError() throws {
        getComicsMock = GetComicsMock()
        usecase = GetComics()
        expectation = expectation(description: "Loading Comics")
    }

    override func tearDownWithError() throws {
        getComicsMock = nil
        usecase = nil
        expectation = nil
    }

    func testGetComicsApiErrorUseCaseReturnTheError() {
        getComicsMock.result = .init(error: HTTPResponse.noContent)
        
        var model: ContentDataWrapper?
                
        getComicsMock.execute(heroId: 190827).done { comicsData in
            model = comicsData
        } .ensure {
            self.expectation.fulfill()
        } .catch { _ in
            model = nil
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(model)
    }
    
    func testGetComicsApiSuccessUseCase() throws {
        let comicsData = try ComicsMock().getComicsMock()
        
        getComicsMock.result = Promise<ContentDataWrapper>.value(comicsData)
        
        var model: ContentDataWrapper?
        
        getComicsMock.execute(heroId: 190827).done { comicsData in
            model = comicsData
        } .ensure {
            self.expectation.fulfill()
        } .catch { _ in
            model = nil
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(model)
    }

}
