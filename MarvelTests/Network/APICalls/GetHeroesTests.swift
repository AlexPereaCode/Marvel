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

    override func setUpWithError() throws {
        getHeroesMock = GetHeroesMock()
        usecase = GetHeroes()
    }

    override func tearDownWithError() throws {
        getHeroesMock = nil
        usecase = nil
    }
    
    func testGetHeroesApiErrorUseCaseReturnTheError() {
        getHeroesMock.result = .init(error: HTTPResponse.noContent)
        
        let expectation = self.expectation(description: "Loading Heroes")
        var model: CharacterDataWrapper?
                
        getHeroesMock.execute(offset: 0).done { characters in
            model = characters
        } .ensure {
            expectation.fulfill()
        } .catch { error in
            model = nil
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(model)
    }
    
    func testGetHeroesApiSuccessUseCase() throws {
        
        guard let path = Bundle(for: type(of: self)).path(forResource: "CharacterTests", ofType: "json") else {
            fatalError("Can't find CharacterTests.json file")
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let characterData = try JSONDecoder().decode(CharacterDataWrapper.self, from: data)
        
        getHeroesMock.result = Promise<CharacterDataWrapper>.value(characterData)
        
        let expectation = self.expectation(description: "Loading Heroes")
        var model: CharacterDataWrapper?
                
        getHeroesMock.execute(offset: 0).done { characters in
            model = characters
        } .ensure {
            expectation.fulfill()
        } .catch { error in
            model = nil
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(model)
    }

}
