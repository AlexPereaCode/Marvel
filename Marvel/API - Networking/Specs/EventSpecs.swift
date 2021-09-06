//
//  EventSpecs.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 6/9/21.
//

import Foundation
import Alamofire

enum EventSpecs {
    case getEvents(heroId: Int, timestamp: String)
}

extension EventSpecs: NetworkProviderSpecs {
    
    var path: String {
        switch self {
        case .getEvents(let heroId, _):
            return "characters/\(heroId)/events"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getEvents(_, let timestamp):
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
