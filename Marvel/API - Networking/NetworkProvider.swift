//
//  NetworkProvider.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation
import Alamofire

public protocol NetworkProviderSpecs {
    var baseURLString: String { get }
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: [String: Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
    var allowOffline: Bool { get }
    var showDebugInfo: Bool { get }
}

extension NetworkProviderSpecs {
    
    var baseURLString: String {
        return "https://gateway.marvel.com/v1/public/"
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        URLEncoding.default
    }
    
    var allowOffline: Bool {
        return false
    }
    
    var showDebugInfo: Bool {
        return true
    }
    
    var url: URL {
        guard let url = URL(string: "\(baseURLString)\(path)") else { fatalError("URL malformed") }
        return url
    }
}

// MARK: -  Network provider
public class NetworkProvider<T: NetworkProviderSpecs> {
    
    public static func request(_ endpoint: T, _ completionHandler: @escaping (AFDataResponse<Any>, NetworkProviderSpecs) -> ())
        -> DataRequest {
            
            return AuthSessionManager
                .current
                .session
                .request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters, encoding: endpoint.parameterEncoding, headers: endpoint.headers)
                .validate()
                .responseJSON(completionHandler: { (response) in
                    
                    if endpoint.showDebugInfo {
                        if let method = response.request?.method?.rawValue {
                            print("\nMETHOD:\n\(method.uppercased())\n")
                        }
                        if let url = response.request?.url?.absoluteString {
                            print("URL:\n\(url)\n")
                        }
                        if let bodyData = response.request?.httpBody, let body = String(data: bodyData, encoding: .utf8) {
                            print("BODY DATA:\n\(body)\n")
                        }
                        if let value = response.error {
                            print("ERROR:\n\(value)\n")
                        }
                        if let data = response.data, let value = String(data: data, encoding: .utf8) {
                            print("RESPONSE DATA:\n\(value)\n")
                        }
                    }
                    completionHandler(response, endpoint)
                })
    }
}


// MARK: - Session manager
class AuthSessionManager {
    static let current = AuthSessionManager()
    let session = Session(interceptor: AuthInterceptor())
}

// MARK:- Auth interceptor
enum InternetError: Error {
    case noConnection
}

class AuthInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Swift.Result<URLRequest, Error>) -> Void) {
        if NetworkReachabilityManager.default?.isReachable == false {
            completion(.failure(InternetError.noConnection))
            return
        }
        completion(.success(urlRequest))
    }
}

