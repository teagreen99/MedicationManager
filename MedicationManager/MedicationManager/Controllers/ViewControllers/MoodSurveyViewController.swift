//
//  MoodSurveyViewController.swift
//  MedicationManager
//
//  Created by Tim Green on 7/28/21.
//

import UIKit

protocol MoodSurveyDelegate: AnyObject {
    func moodButtonTapped(with emoji: String)
}

class MoodSurveyViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: MoodSurveyDelegate?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func moodButtonTapped(_ sender: UIButton) {
        guard let moodEmoji = sender.titleLabel?.text else { return }
        
        delegate?.moodButtonTapped(with: moodEmoji)
        
        dismiss(animated: true, completion: nil)
    }
} // End of class
