//
//  MoodSurveyViewController.swift
//  MedicationManager
//
//  Created by Tim Green on 7/28/21.
//

import UIKit

class MoodSurveyViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: Any) {
    }
    @IBAction func moodButtonTapped(_ sender: UIButton) {
        guard let moodEmoji = sender.titleLabel?.text else { return }
        
        print(sender.tag, moodEmoji)
    }
    
   

} // End of class
