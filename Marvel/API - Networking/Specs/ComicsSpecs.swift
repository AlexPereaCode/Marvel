//
//  ComicsSpecs.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import Foundation
import Alamofire

enum ComicsSpecs {
    case getComics(heroId: Int, timestamp: String)
}

extension ComicsSpecs: NetworkProviderSpecs {
    
    var path: String {
        switch self {
        case .getComics(let heroId, _):
            return "characters/\(heroId)/comics"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getComics(_, let timestamp):
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
