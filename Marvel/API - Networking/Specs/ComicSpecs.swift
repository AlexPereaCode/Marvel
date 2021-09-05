//
//  ComicSpecs.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import Foundation
import Alamofire

enum ComicSpecs {
    case getComics(heroId: Int)
}

extension ComicSpecs: NetworkProviderSpecs {
    
    var path: String {
        switch self {
        case .getComics(let heroId):
            return "characters/\(heroId)/comics"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getComics:
            let timestamp = Credentials.timestamp()
            
            return ["ts": timestamp,
                    "apikey": Credentials.publicKey,
                    "hash": Credentials.hash(timestamp: timestamp)
            ]
        }
    }
    
    var showDebugInfo: Bool {
        return true
    }
    
}
