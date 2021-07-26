//
//  Medication+Convenience.swift
//  MedicationManager
//
//  Created by Tim Green on 7/26/21.
//

import CoreData

extension Medication {
    @discardableResult
    convenience init(name: String, timeOfDay: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.timeOfDay = timeOfDay
    } // End of initializer
} // End of extension


