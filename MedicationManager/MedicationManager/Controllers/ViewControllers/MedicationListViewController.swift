//
//  MedicationListViewController.swift
//  MedicationManager
//
//  Created by Tim Green on 7/26/21.
//

import UIKit

class MedicationListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moodSurveryButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        MedicationController.sharedInstance.fetchMedications()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    
    // MARK: - IBActions
    @IBAction func moodSurveyButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .none)
        guard let moodSurveyVC = storyboard.instantiateViewController(identifier: "moodSurveyViewController") as? MoodSurveyViewController else { return }
        moodSurveyVC.modalPresentationStyle = .fullScreen
        navigationController?.present(moodSurveyVC, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Helper Methods

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditMedication" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? MedicationDetailViewController else { return }
            let medication = MedicationController.sharedInstance.sections[indexPath.section][indexPath.row]
            destination.medication = medication
        }
    }
}

extension MedicationListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MedicationController.sharedInstance.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MedicationController.sharedInstance.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "medicationCell", for: indexPath) as? MedicationTableViewCell else { return UITableViewCell() }
        
        let medication = MedicationController.sharedInstance.sections[indexPath.section][indexPath.row]
        
        cell.configure(with: medication)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Not Taken"
        } else if section == 1 {
            return "Taken"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
} // End of extension

extension MedicationListViewController: MedicationCellDelegate {
    func medicationWasTakenTapped(wasTaken: Bool, medication: Medication) {
        MedicationController.sharedInstance.updateMedicationStatus(wasTaken, medication: medication)
        tableView.reloadData()
    }
} // End of extension
