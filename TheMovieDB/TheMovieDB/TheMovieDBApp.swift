//
//  TheMovieDBApp.swift
//  TheMovieDB
//
//  Created by Mariano Manuel on 7/15/22.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var loggedIn: Bool
    
    init(loggedIn: Bool) {
        self.loggedIn = loggedIn
    }
}

@main
struct TheMovieDBApp: App {
    @ObservedObject var appState = AppState(loggedIn: false)
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            if appState.loggedIn {
                MoviesAndShows()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(appState)
            } else {
                Login()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(appState)
            }
        }
    }
}
