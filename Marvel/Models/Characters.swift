//
//  Characters.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation

struct CharacterDataWrapper: Codable {
    let data: CharacterDataContainer
}

struct CharacterDataContainer: Codable {
    let heroes: [Hero]
    
    enum CodingKeys: String, CodingKey {
        case heroes = "results"
    }
}

struct Hero: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
}
