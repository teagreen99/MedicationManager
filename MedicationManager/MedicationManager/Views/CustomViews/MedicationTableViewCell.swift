//
//  MedicationTableViewCell.swift
//  MedicationManager
//
//  Created by Tim Green on 7/26/21.
//

import UIKit

protocol MedicationCellDelegate: AnyObject {
    func medicationWasTakenTapped(wasTaken: Bool, medication: Medication)
}

class MedicationTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var doseageTimeLabel: UILabel!
    @IBOutlet weak var hasBeenTakenButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: MedicationCellDelegate?
    var medication: Medication?
    private var wasTakenToday: Bool = false
    
    // MARK: - IBActions
    @IBAction func hasBeenTakenButtonTapped(_ sender: Any) {
        
    }
    
    // MARK: - Functions
    func configure(with medication: Medication) {
        self.medication = medication
        
        titleLabel.text = medication.name
        doseageTimeLabel.text = medication.timeOfDay?.dateAsString()
    }
} // End of class
