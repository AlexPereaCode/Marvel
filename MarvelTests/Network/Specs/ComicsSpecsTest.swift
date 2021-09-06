//
//  ComicsSpecsTest.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import XCTest
import Alamofire
@testable import Marvel

class ComicsSpecsTest: XCTestCase {
    
    var stringTimestamp: String!
    var comicsSpec: ComicsSpecs!
    let expectedParametersMessage = "Expected parameters in at this point"
    let id = 125

    override func setUpWithError() throws {
        stringTimestamp = Credentials.timestamp()
        comicsSpec = ComicsSpecs.getComics(heroId: id, timestamp: stringTimestamp)
    }

    override func tearDownWithError() throws {
        comicsSpec = nil
        stringTimestamp = nil
    }

    func testGetComicsBaseURL() {
        XCTAssertTrue(comicsSpec.baseURLString == BaseURLs.marvelURL)
    }
    
    func testGetComicsPath() {
        XCTAssertTrue(comicsSpec.path == "characters/\(id)/comics")
    }
    
    func testGetComicsPathHTTPMethod() {
        XCTAssertTrue(comicsSpec.method == .get)
    }
    
    func testGetComicsTimestampParam() {
        guard let params = comicsSpec.parameters else {
            XCTFail(expectedParametersMessage)
            return
        }
        XCTAssertTrue(params["ts"] as? String == stringTimestamp)
    }
    
    func testGetComicsApikeyParam() {
        guard let params = comicsSpec.parameters else {
            XCTFail(expectedParametersMessage)
            return
        }
        XCTAssertTrue(params["apikey"] as? String == Credentials.publicKey)
    }
    
    func testGetComicsHashParam() {
        guard let params = comicsSpec.parameters else {
            XCTFail(expectedParametersMessage)
            return
        }
        XCTAssertTrue(params["hash"] as? String == Credentials.hash(timestamp: stringTimestamp))
    }
}
