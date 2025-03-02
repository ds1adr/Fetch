//
//  RecipesView.swift
//  FetchTakeHome
//
//  Created by Wontai Ki on 2/28/25.
//

import SwiftUI

struct RecipesView: View {
    enum Constants {
        static let title = NSLocalizedString("Recipes", comment: "Recipes text")
        static let noContents = NSLocalizedString("No Contents", comment: "No Contents")
        static let error = NSLocalizedString("Error", comment: "error text")
        static let noContentsMessage = NSLocalizedString("There is no contents at this time.", comment: "no contents message")
    }
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var viewModel = RecipesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                switch viewModel.viewState {
                case .initialized:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .loaded(let hasRecipes):
                    if hasRecipes {
                        RecipeListView(viewModel: viewModel)
                    } else {
                        ErrorView(viewModel: viewModel, title: Constants.noContents, systemImage: "xmark.icloud", message: Constants.noContentsMessage)
                    }
                case .error:
                    ErrorView(viewModel: viewModel, title: Constants.error, systemImage: "wifi.exclamationmark", message: viewModel.error?.localizedDescription ?? "")
                }
            }
            .navigationTitle(Constants.title)
        }
        .task {
            await viewModel.fetchRecipes()
        }
        .onChange(of: scenePhase) { newValue in
            if newValue == .inactive {
                Task {
                    await ImageRepository.shared.save()
                }
            }
        }
    }
}

struct ErrorView: View {
    var viewModel: RecipesViewModel
    var title: String
    var systemImage: String
    var message: String
    
    var body: some View {
        if #available(iOS 17, *) {
            ContentUnavailableView {
                Label(title, systemImage: systemImage)
            } description: {
                Text(message)
            } actions: {
                Button("Retry") {
                    Task {
                        await viewModel.fetchRecipes()
                    }
                }
            }
        } else {
            VStack(alignment: .center) {
                Spacer()
                VStack(alignment: .center) {
                    Image(systemName: systemImage)
                    Text(title)
                        .font(.headline)
                    Text(message)
                        .font(.caption)
                    Button("Retry") {
                        Task {
                            await viewModel.fetchRecipes()
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    RecipesView()
}
