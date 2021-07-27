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
    
    ///Index 0 == notTaken, Index 1 == taken
    var sections: [[Medication]] { [notTakenMeds, takenMeds] }
    var notTakenMeds: [Medication] = []
    var takenMeds: [Medication] = []
    
    private lazy var fetchRequest: NSFetchRequest<Medication> = {
        let request = NSFetchRequest<Medication>(entityName: "Medication")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    private init() {}
    
    // MARK: - Functions
    func createMedication(name: String, timeOfDay: Date) {
        let medication = Medication(name: name, timeOfDay: timeOfDay)
        notTakenMeds.append(medication)
        print(sections[0][0])
        
        CoreDataStack.saveContext()
    } // End of function
    
    func fetchMedications() {
        let medications = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        takenMeds = medications.filter { $0.wasTakenToday() }
        notTakenMeds = medications.filter { !$0.wasTakenToday() }
    } // End of function
    
    func updateMedicationDetails(_ medication: Medication, name: String, date: Date) {
        medication.name = name
        medication.timeOfDay = date
        
        CoreDataStack.saveContext()
    } // End of function
    
    func updateMedicationStatus(_ wasTaken: Bool, medication: Medication) {
        if wasTaken {
            TakenDate(date: Date(), medication: medication)
            if let index = notTakenMeds.firstIndex(of: medication) {
                notTakenMeds.remove(at: index)
                takenMeds.append(medication)
            }
        } else {
            let mutableTakenDates = medication.mutableSetValue(forKey: "takenDates")
            if let takenDate = (mutableTakenDates as? Set<TakenDate>)?.first(where: { takenDate in
                guard let date = takenDate.date else { return false }
                return Calendar.current.isDate(date, inSameDayAs: Date())
            }) {
                mutableTakenDates.remove(takenDate)
                if let index = takenMeds.firstIndex(of: medication) {
                    takenMeds.remove(at: index)
                    notTakenMeds.append(medication)
                }
            }
        }
        CoreDataStack.saveContext()
    } // End of function
    
    func deleteMedication() {
        
    } // End of function
} // End of class
