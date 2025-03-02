//
//  RecipesViewModel.swift
//  FetchTakeHome
//
//  Created by Wontai Ki on 2/28/25.
//

import Foundation

enum ViewState {
    case initialized
    case loading
    case loaded(hasRecipes: Bool)
    case error
}

//@Observable
// @Observable can't be used in iOS 16.X
class RecipesViewModel: ObservableObject {
    var networkManager: RecipeNetworkManagerProtocol
    @Published var recipes: [Recipe] = []
    @Published var viewState: ViewState = .initialized
    var error: Error?
    
    init(networkManager: RecipeNetworkManagerProtocol = RecipeNetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchRecipes() async {
        Task { @MainActor in
            viewState = .loading
        }
        
        do {
            let recipeResponse: RecipeResponse = try await networkManager.getRecipes()
            Task { @MainActor in
                recipes = recipeResponse.recipes
                viewState = .loaded(hasRecipes: !recipes.isEmpty)
            }
        } catch {
            Task { @MainActor in
                self.error = error
                viewState = .error
            }
        }
    }
}
