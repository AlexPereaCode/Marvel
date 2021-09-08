//
//  CharacterTests.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import XCTest
@testable import Marvel

class CharacterTests: XCTestCase {
    
    var dataWrapper: CharacterDataWrapper?

    override func setUpWithError() throws {
        dataWrapper = try CharacterMock().getCharacterMock()
    }

    override func tearDownWithError() throws {
        dataWrapper = nil
    }

    func testCharacterDataWrapper() {
        XCTAssertNotNil(dataWrapper)
    }
    
    func testCharacterDataContainer() {
        XCTAssertNotNil(dataWrapper?.data)
    }
    
    func testCharacterData() {
        XCTAssertEqual(dataWrapper?.data.heroes.count, 1)
        XCTAssertEqual(dataWrapper?.data.heroes.first?.id, 1011334)
        XCTAssertEqual(dataWrapper?.data.heroes.first?.name, "3-D Man")
        XCTAssertEqual(dataWrapper?.data.heroes.first?.description, "")
    }
    
    func testThumbnail() {
        XCTAssertNotNil(dataWrapper?.data.heroes.first?.thumbnail)
        XCTAssertEqual(dataWrapper?.data.heroes.first?.thumbnail.path, "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784")
        XCTAssertEqual(dataWrapper?.data.heroes.first?.thumbnail.ext, "jpg")
        XCTAssertEqual(dataWrapper?.data.heroes.first?.thumbnail.url, "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")
    }
}
