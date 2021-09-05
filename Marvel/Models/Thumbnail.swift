//
//  Thumbnail.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import Foundation

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
