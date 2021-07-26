//
//  CoreDataStack.swift
//  MedicationManager
//
//  Created by Tim Green on 7/26/21.
//

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "MedicationManager")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error loading persistent stores \(error)")
            }
        }
        return container
    }()
} // End of enum

