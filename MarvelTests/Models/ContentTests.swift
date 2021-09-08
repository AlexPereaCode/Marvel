//
//  ContentTests.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import XCTest
@testable import Marvel

class ContentTests: XCTestCase {
    
    var dataWrapper: ContentDataWrapper?

    override func setUpWithError() throws {
        dataWrapper = try ComicsMock().getComicsMock()
    }

    override func tearDownWithError() throws {
        dataWrapper = nil
    }

    func testContentDataWrapper() {
        XCTAssertNotNil(dataWrapper)
    }
    
    func testContentDataContainer() {
        XCTAssertNotNil(dataWrapper?.data)
    }
    
    func testContentData() {
        XCTAssertEqual(dataWrapper?.data.content.count, 1)
        XCTAssertEqual(dataWrapper?.data.content.first?.id, 22506)
        XCTAssertEqual(dataWrapper?.data.content.first?.title, "Avengers: The Initiative (2007) #19")
    }
    
    func testContentThumbnail() {
        XCTAssertNotNil(dataWrapper?.data.content.first?.thumbnail)
        XCTAssertEqual(dataWrapper?.data.content.first?.thumbnail.path, "http://i.annihil.us/u/prod/marvel/i/mg/d/03/58dd080719806")
        XCTAssertEqual(dataWrapper?.data.content.first?.thumbnail.ext, "jpg")
        XCTAssertEqual(dataWrapper?.data.content.first?.thumbnail.url, "http://i.annihil.us/u/prod/marvel/i/mg/d/03/58dd080719806.jpg")
    }
}
