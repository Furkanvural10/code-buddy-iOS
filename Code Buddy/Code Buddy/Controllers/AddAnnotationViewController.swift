//
//  AddAnnotationViewController.swift
//  Code Buddy
//
//  Created by furkan vural on 12.11.2023.
//

import UIKit

class AddAnnotationViewController: UIViewController {
    
    // MARK: - TextFields
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userTitleTextField: UITextField!
    
    // MARK: - SegmentedControler
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    
    // MARK: - Button
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Profile Image Add
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        // MARK: - SegmentedControl UI
        statusSegmentedControl.selectedSegmentTintColor = .systemGreen
        
        // MARK: - SaveButton UI
        
    }
    @IBAction func statusSegmentedChanged(_ sender: Any) {
        
        let index = statusSegmentedControl.selectedSegmentIndex
        switch index {
        case 0:
            statusSegmentedControl.selectedSegmentTintColor = .systemGreen
        case 1:
            statusSegmentedControl.selectedSegmentTintColor = .systemYellow
        default:
            statusSegmentedControl.selectedSegmentTintColor = .systemRed
        }
        
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
    }
    
}
