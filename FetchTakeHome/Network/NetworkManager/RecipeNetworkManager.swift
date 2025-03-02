//
//  NetworkManager.swift
//  FetchTakeHome
//
//  Created by Wontai Ki on 2/28/25.
//

import Foundation

protocol RecipeNetworkManagerProtocol {
    func getRecipes() async throws -> RecipeResponse
}

final class RecipeNetworkManager: RecipeNetworkManagerProtocol {
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getRecipes() async throws -> RecipeResponse {
        return try await networkService.perform(router: RecipesAPIRouter.getRecipes)
    }
}

