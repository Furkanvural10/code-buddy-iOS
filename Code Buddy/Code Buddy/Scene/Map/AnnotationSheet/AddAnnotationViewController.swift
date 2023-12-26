//
//  AddAnnotationViewController.swift
//  Code Buddy
//
//  Created by furkan vural on 12.11.2023.
//

import UIKit

final class AddAnnotationViewController: UIViewController {
    
    // MARK: - TextFields
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userTitleTextField: UITextField!
    
    // MARK: - SegmentedControler
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    
    // MARK: - Button
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Profile Image Add
    @IBOutlet weak var profileImage: UIImageView!
    
    // MARK: - Gesture Recognizer
    let gestureRecognizer = UIGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureImage()
    }
    
    
    
    private func setupUI() {
        
        // MARK: - SegmentedControl UI
        statusSegmentedControl.selectedSegmentTintColor = .systemGreen
        
        // MARK: - SaveButton UI
        saveButton.setTitle("Save", for: .normal)
        
    }
    
    private func configureImage() {
        profileImage.isUserInteractionEnabled = true
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.clipsToBounds = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        profileImage.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc private func chooseImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.isEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    @IBAction func statusSegmentedChanged(_ sender: Any) {
        
//        VM
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
        print("VM Func called")
    }
    
}

extension AddAnnotationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
}
