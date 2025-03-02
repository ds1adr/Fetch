//
//  NetworkService.swift
//  FetchTakeHome
//
//  Created by Wontai Ki on 2/28/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func perform<T: Decodable>(router: APIRouterProtocol) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    func perform<T: Decodable>(router: any APIRouterProtocol) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: router.getURLRequest())
        guard let urlResponse = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        
        guard (200...299).contains(urlResponse.statusCode) else {
            throw NetworkError.networkError(statusCode: urlResponse.statusCode)
        }
        
        do {
            let jsonDecoded: T = try JSONDecoder().decode(T.self, from: data)
            return jsonDecoded
        } catch {
            throw NetworkError.invalidData
        }
    }
}
