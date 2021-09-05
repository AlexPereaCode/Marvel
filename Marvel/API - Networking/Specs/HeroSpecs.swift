//
//  HeroSpecs.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation
import Alamofire

enum HeroSpecs {
    case getHeroes(offset: Int)
}

extension HeroSpecs: NetworkProviderSpecs {
    
    var path: String {
        return "characters"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getHeroes(let offset):
            let timestamp = Credentials.timestamp()
            
            return ["offset": offset,
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
