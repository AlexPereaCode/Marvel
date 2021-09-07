//
//  EventSpecsTests.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import XCTest
import Alamofire
@testable import Marvel

class EventSpecsTests: XCTestCase {
    
    var stringTimestamp: String!
    var eventSpec: EventSpecs!
    let expectedParametersMessage = "Expected parameters in at this point"
    let id = 365

    override func setUpWithError() throws {
        stringTimestamp = Credentials.timestamp()
        eventSpec = EventSpecs.getEvents(heroId: id, timestamp: stringTimestamp)
    }

    override func tearDownWithError() throws {
        eventSpec = nil
        stringTimestamp = nil
    }
    
    func testGetEventsBaseURL() {
        XCTAssertTrue(eventSpec.baseURLString == Credentials.marvelURL)
    }

    func testGetEventsPath() {
        XCTAssertTrue(eventSpec.path == "characters/\(id)/events")
    }
    
    func testGetEventsPathHTTPMethod() {
        XCTAssertTrue(eventSpec.method == .get)
    }
    
    func testGetEventsTimestampParam() {
        guard let params = eventSpec.parameters else {
            XCTFail(expectedParametersMessage)
            return
        }
        XCTAssertTrue(params["ts"] as? String == stringTimestamp)
    }
    
    func testGetEventsApikeyParam() {
        guard let params = eventSpec.parameters else {
            XCTFail(expectedParametersMessage)
            return
        }
        XCTAssertTrue(params["apikey"] as? String == Credentials.publicKey)
    }
    
    func testGetEventsHashParam() {
        guard let params = eventSpec.parameters else {
            XCTFail(expectedParametersMessage)
            return
        }
        XCTAssertTrue(params["hash"] as? String == Credentials.hash(timestamp: stringTimestamp))
    }
}
