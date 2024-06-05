//
//  MessingWithAppleWatchApp.swift
//  MessingWithAppleWatch Watch App
//
//  Created by Fabio Freitas on 02/05/24.
//

import SwiftUI

@main
struct MessingWithAppleWatch_Watch_AppApp: App {
    
    @StateObject var coreData = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            MessingWithNavigation()
                .environment(\.managedObjectContext, coreData.persistentContainer.viewContext)
        }
    }
}
