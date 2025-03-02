//
//  APIRouterProtocol.swift
//  FetchTakeHome
//
//  Created by Wontai Ki on 2/28/25.
//

import Foundation

enum APIConstants {
    static let scheme = "https"
    static let host = "d3jbb8n5wk0qxi.cloudfront.net"
}

protocol APIRouterProtocol {
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: [String: Any] { get }
}

extension APIRouterProtocol {
    var host: String {
        APIConstants.host
    }
    
    var params: [String: Any] {
        [:]
    }
    
    func getURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = APIConstants.scheme
        urlComponents.host = host
        urlComponents.path = path
        
        guard let url = urlComponents.url else { throw NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        
        return urlRequest
    }
}
