//
//  FetchTakeHomeTests.swift
//  FetchTakeHomeTests
//
//  Created by Wontai Ki on 2/28/25.
//

import XCTest
import Combine
@testable import FetchTakeHome

final class FetchTakeHomeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRecipesViewModel_GetRecipe_Normal() async throws {
        // Given
        let networkManager = MockRecipeNetworkManager(desiredResponse: .normal)
        let viewModel = RecipesViewModel(networkManager: networkManager)
        
        // When
        await viewModel.fetchRecipes()
        
        // Then
        XCTAssertEqual(viewModel.recipes.count, 2)
    }

    func testRecipesViewModel_GetRecipe_Error() async throws {
        // Given
        let networkManager = MockRecipeNetworkManager(desiredResponse: .error(error: NetworkError.badResponse))
        let viewModel = RecipesViewModel(networkManager: networkManager)
        let expectation = XCTestExpectation(description: "Error case")
        var cancellable: AnyCancellable?
        
        cancellable = viewModel.$viewState.dropFirst().sink { _ in
            expectation.fulfill()
        }
        
        // When
        await viewModel.fetchRecipes()
        
        await fulfillment(of: [expectation], timeout: 2.0)
        // Then
        let error = viewModel.error as! NetworkError
        XCTAssertEqual(error, NetworkError.badResponse)
        cancellable?.cancel()
    }
}
