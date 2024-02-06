#warning("Fixed Hard Coded")

import UIKit

final class AddAnnotationViewController: UIViewController {
    
    // MARK: - TextFields
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userTitleTextField: UITextField!
    
    // MARK: - SegmentedControler
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    
    // MARK: - Add Image Label
    @IBOutlet weak var addImageLabel: UILabel!
    
    // MARK: - Button
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Profile Image Add
    @IBOutlet weak var profileImage: UIImageView!
    
    // MARK: - Gesture Recognizer
    let gestureRecognizer = UIGestureRecognizer()
    
    private let viewModel = AddAnnotationViewModel()
    private var status: String = "Working"
    var latitude: Double?
    var longitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureImage()
        viewModel.statusChangedClosure = { [weak self] color in
            self?.updateStatusUI(color: color)
        }
    }

    private func setupUI() {
        view.backgroundColor = UIColor(named: "BackgroundColor") // Fix later!
        
        // MARK: - SegmentedControl UI
        
        let statusSegmentedControlTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.white]
        statusSegmentedControl.backgroundColor = .black
        statusSegmentedControl.layer.cornerRadius = 5
        statusSegmentedControl.layer.borderWidth = 0.4
        statusSegmentedControl.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        statusSegmentedControl.selectedSegmentTintColor = .systemGreen
        statusSegmentedControl.setTitleTextAttributes(statusSegmentedControlTextAttribute, for: .normal)

        
        // MARK: - SaveButton UI
        saveButton.setTitle("Save", for: .normal)
        
        // MARK: - UsernameTextField UI
        let attributedStringForNameTextField = NSAttributedString(string: "Name: John Patric", attributes: [
            .foregroundColor: UIColor.white.withAlphaComponent(0.5)
        ])
        
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.backgroundColor = .black
        usernameTextField.clearButtonMode = .whileEditing

        usernameTextField.attributedPlaceholder = attributedStringForNameTextField
        
        usernameTextField.layer.borderWidth = 0.4
        usernameTextField.layer.cornerRadius = 5
        usernameTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        usernameTextField.textColor = .white.withAlphaComponent(0.8)
        usernameTextField.keyboardAppearance = .dark
        
        // MARK: - UserTitleTextField
        let attributedStringForTitleTextField = NSAttributedString(string: "Title: iOS Developer", attributes: [
            .foregroundColor: UIColor.white.withAlphaComponent(0.5)
        ])
        
        userTitleTextField.borderStyle = .roundedRect
        userTitleTextField.backgroundColor = .black
        userTitleTextField.clearButtonMode = .whileEditing
        userTitleTextField.textColor = .white.withAlphaComponent(0.8)
        userTitleTextField.attributedPlaceholder = attributedStringForTitleTextField
        userTitleTextField.layer.borderWidth = 0.4
        userTitleTextField.layer.cornerRadius = 5
        userTitleTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        userTitleTextField.keyboardAppearance = .dark
        
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
        
        let name = usernameTextField.text!
        let title = usernameTextField.text!
        let image = profileImage.image?.jpegData(compressionQuality: 50)
        let status = status
        let location = Location(latitude: latitude!, longitude: longitude!)
        let user = User(name: name, title: title, image: image!, status: status, location: location)
        
        viewModel.saveUserInfo(user: user)
    }
    
}

extension AddAnnotationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        profileImage.image = info[.originalImage] as? UIImage
        self.addImageLabel.text = "Update"
        self.dismiss(animated: true)
    }
}
