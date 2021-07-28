//
//  MoodSurvey+Convenience.swift
//  MedicationManager
//
//  Created by Tim Green on 7/28/21.
//

import CoreData

extension MoodSurvey {
    
    @discardableResult
    convenience init(mentalState: String, date: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.mentalState = mentalState
        self.date = date
    }
} // End of extension
