//
//  NetworkRequest.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation
import Alamofire
import PromiseKit

enum HTTPResponse: Int, Decodable, Error {
    case noContent = 204
}

class NetworkRequest<S: NetworkProviderSpecs, R: Codable> {
    
    public static func make(specs: S) -> Promise<R> {
        return Promise<R> { seal in
            NetworkRequest.make(specs: specs) { result in
                switch result {
                case .success(let value):
                    seal.fulfill(value)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    @discardableResult
    private static func make(specs: S, _ completion: @escaping (Swift.Result<R, Error>) -> Swift.Void) -> DataRequest {
        return NetworkProvider<S>.request(specs) { (response, specs) in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion(.failure(HTTPResponse.noContent))
                    return
                }
                
                do {
                    let parsed: R = try JSONDecoder().decode(R.self, from: data)
                    completion(.success(parsed))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

