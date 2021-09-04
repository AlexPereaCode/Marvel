//
//  DownloadImageUseCase.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation
import PromiseKit
import SDWebImage

protocol DownloadImageUseCase {
    func execute(urlString: String) -> Promise<UIImage>
}

struct DownloadImage: DownloadImageUseCase {
    private let downloader = SDWebImageManager.shared
    
    func execute(urlString: String) -> Promise<UIImage> {
        return Promise<UIImage> { seal in
            guard let url = URL(string: urlString) else {
                return
            }
            
            downloader.loadImage(with: url, options: [.highPriority, .retryFailed, .continueInBackground], progress: nil) { (image, data, error, cacheType, completed, url) in
                if let image = image {
                    seal.fulfill(image)
                }
            }
        }
    }
}
