//
//  SwiftUIView.swift
//  FetchTakeHome
//
//  Created by Wontai Ki on 2/28/25.
//

import SwiftUI

struct RecipeListView: View {
    @ObservedObject var viewModel: RecipesViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.recipes, id: \.id) { recipe in
                RecipeView(recipe: recipe)
            }
        }
    }
}

struct RecipeView: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            ImageView(viewModel: ImageViewModel(urlString: recipe.photoURLSmallString))
                .frame(width: ImageConstants.thumbnailSize, height: ImageConstants.thumbnailSize)
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                Text(recipe.cuisine)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    RecipeListView(viewModel: RecipesViewModel())
}
