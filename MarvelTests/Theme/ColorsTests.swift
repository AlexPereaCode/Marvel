//
//  ColorsTests.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import XCTest
@testable import Marvel

class ColorsTests: XCTestCase {

    func testAccentColor() {
        XCTAssertEqual(Colors.accentColor, #colorLiteral(red: 0.9686274529, green: 0, blue: 0, alpha: 1))
    }
    
    func testTextColor() {
        XCTAssertEqual(Colors.textColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }

    func testBackgroundColor() {
        XCTAssertEqual(Colors.backgroundColor, #colorLiteral(red: 0.1207732368, green: 0.1207732368, blue: 0.1207732368, alpha: 1))
    }
}
