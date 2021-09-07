//
//  Credentials.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation
import CryptoKit

class Credentials {
    static let marvelURL = "https://gateway.marvel.com/v1/public/"
    static let privateKey = "123e18e3f29c45f6009ff2466982d8a6b80290f1"
    static let publicKey = "4b32648101fc6103d4d05f041d3c4731"
    
    public class func hash(timestamp: String) -> String {
        return MD5(data: "\(timestamp)\(Credentials.privateKey)\(Credentials.publicKey)")
    }
    
    public class func timestamp() -> String {
        return String(Date().timeIntervalSince1970)
    }
    
    private class func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return hash.map{
            String(format: "%02hhx", $0)
        }.joined()
    }
}
