//
//  CredentialTests.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import XCTest
@testable import Marvel

class CredentialTests: XCTestCase {
    
    func testMarvelPublicUrl() {
        XCTAssertEqual(Credentials.marvelURL, "https://gateway.marvel.com/v1/public/")
    }
    
    func testPrivateKey() {
        XCTAssertEqual(Credentials.privateKey, "123e18e3f29c45f6009ff2466982d8a6b80290f1")
    }
    
    func testPublicKey() {
        XCTAssertEqual(Credentials.publicKey, "4b32648101fc6103d4d05f041d3c4731")
    }
    
    func testGenerateHash() {
        let timestamp = "1631019865.023994"
        XCTAssertEqual(Credentials.hash(timestamp: timestamp), "22900ac88ae3b9e0d37fc0f545b17589")
    }
}
