//
//  HeroesSpecs.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation
import Alamofire

enum HeroesSpecs {
    case getHeroes(offset: Int, limit: Int)
}

extension HeroesSpecs: NetworkProviderSpecs {
    
    var path: String {
        return "characters"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getHeroes(let offset, let limit):
            let timestamp = Credentials.timestamp()
            
            return ["offset": offset,
                    "limit": limit,
                    "ts": timestamp,
                    "apikey": Credentials.publicKey,
                    "hash": Credentials.hash(timestamp: timestamp)
            ]
        }
    }
    
    var showDebugInfo: Bool {
        return true
    }

}