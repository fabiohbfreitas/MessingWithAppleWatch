//
//  CoreDataStack.swift
//  MessingWithAppleWatch Watch App
//
//  Created by Fabio Freitas on 05/06/24.
//

import Foundation
import CoreData

class CoreDataStack: ObservableObject {
    var inMemory: Bool = false
    
    static let shared = CoreDataStack()
    static let preview = CoreDataStack(isTemporary: true)
    
    var containerURL: URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.MessingWithAppleWatch.watchApp")!
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        if (!inMemory) {
            let storeURL = containerURL.appendingPathComponent("MessingWithAppleWatch.sqlite")
            container.persistentStoreDescriptions.first!.url = storeURL
        } else {
            let storeDesc = container.persistentStoreDescriptions.first
            storeDesc?.type = NSInMemoryStoreType
            storeDesc?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
        
    private init() { }
    
    private init(isTemporary: Bool) {
        inMemory = isTemporary
    }
    
}
