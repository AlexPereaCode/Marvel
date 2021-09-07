//
//  DownloadImageTests.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import XCTest
import Alamofire
import PromiseKit
@testable import Marvel

class DownloadImageTests: XCTestCase {
    
    var downloadImageMock: DownloadImageMock!
    var usecase: DownloadImageUseCase!
    var expectation: XCTestExpectation!

    override func setUpWithError() throws {
        downloadImageMock = DownloadImageMock()
        usecase = DownloadImage()
        expectation = expectation(description: "Loading Image")
    }

    override func tearDownWithError() throws {
        downloadImageMock = nil
        usecase = nil
        expectation = nil
    }

    func testDownloadImageApiError() {
        downloadImageMock.result = .init(error: HTTPResponse.noContent)
        var aImage: UIImage?
                
        downloadImageMock.execute(urlString: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg").done { image in
            aImage = image
        } .ensure {
            self.expectation.fulfill()
        } .catch { _ in
            aImage = nil
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(aImage)
    }
    
    func testDownloadImageApiSuccessUseCase() throws {
        downloadImageMock.result = Promise<UIImage>.value(UIImage(named: "spiderman")!)
        var aImage: UIImage?

        downloadImageMock.execute(urlString: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg").done { image in
            aImage = image
        } .ensure {
            self.expectation.fulfill()
        } .catch { _ in
            aImage = nil
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(aImage)
    }
}
