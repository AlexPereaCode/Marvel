//
//  DownloadImageMock.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import UIKit
import PromiseKit
@testable import Marvel

class DownloadImageMock: DownloadImageUseCase {
    
    var result: Promise<UIImage> = Promise<UIImage>(error: HTTPResponse.noContent)
    
    func execute(urlString: String) -> Promise<UIImage> {
        return result
    }
}
