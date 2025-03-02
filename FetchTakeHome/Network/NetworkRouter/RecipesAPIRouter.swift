//
//  RecipesAPIRouter.swift
//  FetchTakeHome
//
//  Created by Wontai Ki on 2/28/25.
//

import Foundation

enum RecipesAPIRouter: APIRouterProtocol {
    case getRecipes
    
    var path: String {
        "/recipes.json"
        //"/ecipes-malformed.json"
        //"/recipes-empty.json"
    }
    
    var method: HTTPMethod {
        .GET
    }
}
