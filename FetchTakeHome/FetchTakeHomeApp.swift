//
//  FetchTakeHomeApp.swift
//  FetchTakeHome
//
//  Created by Wontai Ki on 2/28/25.
//

import SwiftUI

@main
struct FetchTakeHomeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RecipesView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
