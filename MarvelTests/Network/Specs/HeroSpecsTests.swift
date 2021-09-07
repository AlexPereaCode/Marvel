//
//  HeroSpecsTests.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 6/9/21.
//

import XCTest
import Alamofire
@testable import Marvel

class HeroSpecsTests: XCTestCase {
    
    var stringTimestamp: String!
    var heroSpec: HeroSpecs!
    let offset = 0
    let expectedParametersMessage = "Expected parameters in at this point"
    
    override func setUpWithError() throws {
        stringTimestamp = Credentials.timestamp()
        heroSpec = HeroSpecs.getHeroes(offset: offset, timestamp: stringTimestamp)
    }

    override func tearDownWithError() throws {
        heroSpec = nil
        stringTimestamp = nil
    }

    func testGetHeroesBaseURL() {
        XCTAssertTrue(heroSpec.baseURLString == Credentials.marvelURL)
    }
    
    func testGetHeroesPath() {
        XCTAssertTrue(heroSpec.path == "characters")
    }
    
    func testGetHeroesPathHTTPMethod() {
        XCTAssertTrue(heroSpec.method == .get)
    }

    func testGetHeroesOffsetParam() {
        guard let params = heroSpec.parameters else {
            XCTFail(expectedParametersMessage)
            return
        }
        XCTAssertTrue(params["offset"] as? Int == offset)
    }
    
    func testGetHeroesTimestampParam() {
        guard let params = heroSpec.parameters else {
            XCTFail(expectedParametersMessage)
            return
        }
        XCTAssertTrue(params["ts"] as? String == stringTimestamp)
    }
    
    func testGetHeroesApikeyParam() {
        guard let params = heroSpec.parameters else {
            XCTFail(expectedParametersMessage)
            return
        }
        XCTAssertTrue(params["apikey"] as? String == Credentials.publicKey)
    }
    
    func testGetHeroesHashParam() {
        guard let params = heroSpec.parameters else {
            XCTFail(expectedParametersMessage)
            return
        }
        XCTAssertTrue(params["hash"] as? String == Credentials.hash(timestamp: stringTimestamp))
    }
}
