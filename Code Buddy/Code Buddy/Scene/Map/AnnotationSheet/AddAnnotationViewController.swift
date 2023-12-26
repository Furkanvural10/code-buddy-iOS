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
    
    private let viewModel = AddAnnotationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureImage()
        viewModel.statusChangedClosure = { [weak self] color in
            self?.updateStatusUI(color: color)
        }
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
    
    func updateStatusUI(color: UIColor) {
        statusSegmentedControl.selectedSegmentTintColor = color
    }

    @IBAction func statusSegmentedChanged(_ sender: Any) {
        let index = statusSegmentedControl.selectedSegmentIndex
        viewModel.updateStatus(index: index)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        viewModel.saveUserInfo()
    }
    
}

extension AddAnnotationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
}
