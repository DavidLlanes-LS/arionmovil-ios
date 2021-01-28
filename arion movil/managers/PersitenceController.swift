//
//  PersitenceController.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 26/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct PersistenceController{
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    init(){
        container = NSPersistentContainer(name:"SongsDB")
        container.loadPersistentStores { (StoreDescription, error) in
            if let error = error as NSError?{
                fatalError("Unresolved error: \(error)")}
        }
    }
}
struct MyCoreBack {
    
    static let shared = MyCoreBack()
    
    var background: NSManagedObjectContext
    
    
    
    init() {
        let childContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        //        print("created childContext-------->")
        
        childContext.parent = PersistenceController.shared.container.viewContext
        
        childContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        // Set unused undoManager to nil for macOS (it is nil by default on iOS)
        
        // to reduce resource requirements.
        
        childContext.undoManager = nil
        
        childContext.automaticallyMergesChangesFromParent = true
        
        self.background = childContext
        
    }
    
    
    
}

extension NSManagedObjectContext {
    func saveIfNeeded() {
        if hasChanges {
            do {
                try save()
            } catch {
                print("Error: \(error)\nCould not save Core Data context.")
                return
            }
        }
        // Reset the taskContext to free the cache and lower the memory footprint.
        //reset()
    }
}

public extension CodingUserInfoKey {

    // Helper property to retrieve the context

    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")

}
