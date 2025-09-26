//
//  CREDDemoApp.swift
//  CREDDemo
//
//  Created by Pat Murphy on 9/24/25.
//

import SwiftUI
import SwiftData


@main
struct CREDDemoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    
    var body: some Scene {
        WindowGroup {
            CharacterListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
