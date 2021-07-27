//
//  MedicationController.swift
//  MedicationManager
//
//  Created by Tim Green on 7/26/21.
//

import CoreData

class MedicationController {
    
    // MARK: - Properties
    static let sharedInstance = MedicationController()
    
    var medications: [Medication] = []
    
    private lazy var fetchRequest: NSFetchRequest<Medication> = {
        let request = NSFetchRequest<Medication>(entityName: "Medication")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    private init() {}
    
    // MARK: - Functions
    func createMedication(name: String, timeOfDay: Date) {
        let medication = Medication(name: name, timeOfDay: timeOfDay)
        medications.append(medication)
        
        CoreDataStack.saveContext()
    } // End of function
    
    func fetchMedications() {
        let medications = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        print(medications.count)
        self.medications = medications
    } // End of function
    
    func updateMedication(_ medication: Medication, name: String, date: Date) {
        medication.name = name
        medication.timeOfDay = date
        
        CoreDataStack.saveContext()
    } // End of function
    
    func deleteMedication() {
        
    } // End of function
} // End of class
