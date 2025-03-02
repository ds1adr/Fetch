//
//  RecipesDataModel.swift
//  FetchTakeHome
//
//  Created by Wontai Ki on 2/28/25.
//

import Foundation

struct Recipe: Codable, Identifiable, Hashable {
    let id: String
    let cuisine: String
    let name: String
    let photoURLLargeString: String
    let photoURLSmallString: String
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case photoURLLargeString = "photo_url_large"
        case photoURLSmallString = "photo_url_small"
    }
}

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}
