//
//  Content.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import Foundation

struct ContentDataWrapper: Codable {
    let data: ContentDataContainer
}

struct ContentDataContainer: Codable {
    let content: [Content]
    
    enum CodingKeys: String, CodingKey {
        case content = "results"
    }
    
    var getImagesURL: [String] {
        var urls = [String]()
        content.forEach { urls.append($0.thumbnail.url) }
        return urls
    }
}

struct Content: Codable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail
}
