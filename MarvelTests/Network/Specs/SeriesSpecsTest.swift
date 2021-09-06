//
//  SeriesSpecsTest.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import XCTest
import Alamofire
@testable import Marvel

class SeriesSpecsTest: XCTestCase {
    
    var stringTimestamp: String!
    var seriesSpec: SeriesSpecs!
    let expectedParametersMessage = "Expected parameters in at this point"
    let id = 654

    override func setUpWithError() throws {
        stringTimestamp = Credentials.timestamp()
        seriesSpec = SeriesSpecs.getSeries(heroId: id, timestamp: stringTimestamp)
    }

    override func tearDownWithError() throws {
        seriesSpec = nil
        stringTimestamp = nil
    }

    func testGetSeriesBaseURL() {
        XCTAssertTrue(seriesSpec.baseURLString == BaseURLs.marvelURL)
    }

    func testGetSeriesPath() {
        XCTAssertTrue(seriesSpec.path == "characters/\(id)/series")
    }
    
    func testGetSeriesPathHTTPMethod() {
        XCTAssertTrue(seriesSpec.method == .get)
    }
    
    func testGetSeriesTimestampParam() {
        guard let params = seriesSpec.parameters else {
            XCTFail(expectedParametersMessage)
            return
        }
        XCTAssertTrue(params["ts"] as? String == stringTimestamp)
    }
    
    func testGetSeriesApikeyParam() {
        guard let params = seriesSpec.parameters else {
            XCTFail(expectedParametersMessage)
            return
        }
        XCTAssertTrue(params["apikey"] as? String == Credentials.publicKey)
    }
    
    func testGetSeriesHashParam() {
        guard let params = seriesSpec.parameters else {
            XCTFail(expectedParametersMessage)
            return
        }
        XCTAssertTrue(params["hash"] as? String == Credentials.hash(timestamp: stringTimestamp))
    }
}
