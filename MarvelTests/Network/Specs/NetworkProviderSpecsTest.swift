//
//  NetworkProviderSpecsTest.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 6/9/21.
//

import XCTest
import Alamofire
@testable import Marvel

class NetworkProviderSpecsTest: XCTestCase {
    
    class NetworkProviderSpecMock: NetworkProviderSpecs {
        var path: String = "test/path"
        var method: HTTPMethod = .get
        var parameters: [String : Any]?
    }
    
    var spec: NetworkProviderSpecMock!

    override func setUpWithError() throws {
        spec = NetworkProviderSpecMock()
    }

    override func tearDownWithError() throws {
        spec = nil
    }

    func testNetworkProviderSpecURLDefault() {
        let expectedURL = URL(string: "\(BaseURLs.marvelURL)\(spec.path)")!
        XCTAssertTrue(spec.url == expectedURL)
    }
    
    func testNetworkProviderSpecBaseURLDefault() {
        XCTAssertTrue(spec.baseURLString == BaseURLs.marvelURL)
    }
    
    func testNetworkProviderSpecAllowOfflineDefault() {
        XCTAssertTrue(!spec.allowOffline)
    }
}
