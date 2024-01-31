//
//  DataController.swift
//  MovieApp
//
//  Created by yusef naser on 30/01/2024.
//

import Foundation
import CoreData

class DataController {
    
    static var shared = DataController(modelName: "Movies")
    
    let persistanceContainer : NSPersistentContainer
    
    var viewContext : NSManagedObjectContext {
        persistanceContainer.viewContext
    }
    
    var backgroundContext : NSManagedObjectContext!
    
    init(modelName : String) {
        persistanceContainer = NSPersistentContainer(name: modelName)
    }
    
    func configureContexts () {
        backgroundContext = persistanceContainer.newBackgroundContext()
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func load(completion : ( ()->Void )? = nil ) {
        persistanceContainer.loadPersistentStores { (description, error) in
            guard error == nil else {
                return
            }
            self.configureContexts()
            completion?()
        }
    }
    
    func save () {
        if viewContext.hasChanges {
            try? viewContext.save()
        }
    }
    
}

