//
//  NetworkError.swift
//  FetchTakeHome
//
//  Created by Wontai Ki on 2/28/25.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidData
    case badResponse
    case networkError(statusCode: Int)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            "Invalied URL"
        case .invalidData:
            "Data is not valied"
        case .badResponse:
            "Network response is not valid"
        case .networkError(let code):
            "Network Error, code = \(code)"
        }
    }
}
