//
//  MockNetworkManager.swift
//  FetchTakeHomeTests
//
//  Created by Wontai Ki on 3/1/25.
//

import Foundation
@testable import FetchTakeHome

enum ResponseType {
    case empty
    case normal
    case error(error: NetworkError)
}

class MockRecipeNetworkManager: RecipeNetworkManagerProtocol {
    
    // Local file would be used for the response
    let response: String = """
    {
        "recipes": [
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            },
            {
                "cuisine": "British",
                "name": "Apple & Blackberry Crumble",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
            }
        ]
    }
"""
    var desiredResponse: ResponseType
    
    init(desiredResponse: ResponseType) {
        self.desiredResponse = desiredResponse
    }
    
    var getRecipesCalled = false
    func getRecipes() async throws -> FetchTakeHome.RecipeResponse {
        getRecipesCalled = true
        switch desiredResponse {
        case .empty:
            return RecipeResponse(recipes: [])
        case .normal:
            let jsonData = response.data(using: .utf8)!
            let recipeResponse = try! JSONDecoder().decode(FetchTakeHome.RecipeResponse.self, from: jsonData)
            return recipeResponse
        case .error(let error):
            let msg = error.localizedDescription
            throw error
        }
        
    }
}
