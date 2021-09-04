//
//  Characters.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation

struct Characters: Codable {
    let data: HeroesData
}

struct HeroesData: Codable {
    let offset, limit, total, count: Int
    let heroes: [Hero]
    
    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case heroes = "results"
    }
}

struct Hero: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let path: String
    let ext: String
    
    var url: String {
        return "\(path).\(ext)"
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

struct HeroURL: Codable {
    let type: String
    let url: String
}
