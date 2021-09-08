//
//  GetHeroesTests.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import XCTest
import Alamofire
import PromiseKit
@testable import Marvel

class GetHeroesTests: XCTestCase {
    
    var getHeroesMock: GetHeroesMock!
    var usecase: GetHeroesUseCase!
    var expectation: XCTestExpectation!

    override func setUpWithError() throws {
        getHeroesMock = GetHeroesMock()
        usecase = GetHeroes()
        expectation = expectation(description: "Loading Heroes")
    }

    override func tearDownWithError() throws {
        getHeroesMock = nil
        usecase = nil
        expectation = nil
    }
    
    func testGetHeroesApiErrorUseCaseReturnTheError() {
        getHeroesMock.result = .init(error: HTTPResponse.noContent)
        
        var model: CharacterDataWrapper?
                
        getHeroesMock.execute(offset: 0).done { characters in
            model = characters
        } .ensure {
            self.expectation.fulfill()
        } .catch { _ in
            model = nil
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(model)
    }
    
    func testGetHeroesApiSuccessUseCase() throws {
        let characterData = try CharacterMock().getCharacterMock()
        
        getHeroesMock.result = Promise<CharacterDataWrapper>.value(characterData)
        
        var model: CharacterDataWrapper?
                
        getHeroesMock.execute(offset: 0).done { characters in
            model = characters
        } .ensure {
            self.expectation.fulfill()
        } .catch { _ in
            model = nil
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(model)
    }

}
