//
//  Comics.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import Foundation

struct ComicDataWrapper: Codable {
    let data: ComicDataContainer
}

struct ComicDataContainer: Codable {
    let comics: [Comic]
    
    enum CodingKeys: String, CodingKey {
        case comics = "results"
    }
}

struct Comic: Codable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail
}
