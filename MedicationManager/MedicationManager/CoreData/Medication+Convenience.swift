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
    
    func wasTakenToday() -> Bool {
        guard let _ = (takenDates as? Set<TakenDate>)?.first(where: { takenDate in
            guard let day = takenDate.date else { return false }
            
            return Calendar.current.isDate(day, inSameDayAs: Date())
            
        })
        else { return false }
        return true
    }
} // End of extension


