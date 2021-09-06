//
//  SeriesSpecs.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 6/9/21.
//

import Foundation
import Alamofire

enum SeriesSpecs {
    case getSeries(heroId: Int)
}

extension SeriesSpecs: NetworkProviderSpecs {
    
    var path: String {
        switch self {
        case .getSeries(let heroId):
            return "characters/\(heroId)/series"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getSeries:
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
