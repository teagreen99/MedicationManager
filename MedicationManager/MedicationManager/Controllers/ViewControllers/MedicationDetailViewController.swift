//
//  MedicationDetailViewController.swift
//  MedicationManager
//
//  Created by Tim Green on 7/26/21.
//

import UIKit

class MedicationDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Properties
    var medication: Medication?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
     
    }
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
              !name.isEmpty else { return }
        if let medication = medication {
            MedicationController.sharedInstance.updateMedicationDetails(medication, name: name, date: datePicker.date)
        } else {
            MedicationController.sharedInstance.createMedication(name: name, timeOfDay: datePicker.date)
        }
        navigationController?.popViewController(animated: true)
    }

    
    // MARK: - Functions
    func updateViews() {
        guard let medication = medication else { return }
        nameTextField.text = medication.name
        datePicker.date = medication.timeOfDay ?? Date()
    }


} // End of class
