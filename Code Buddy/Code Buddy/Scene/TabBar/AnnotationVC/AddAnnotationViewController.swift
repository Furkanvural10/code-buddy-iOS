import UIKit

final class AddAnnotationViewController: UIViewController {

    
    // MARK: - TextFields
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userTitleTextField: UITextField!
    
    // MARK: - TextFields Labels
    @IBOutlet weak var usernameTitle: UILabel!
    @IBOutlet weak var usertitle: UILabel!
    
    // MARK: - Toggle Label
    @IBOutlet weak var toggleLabel: UILabel!
    
    // MARK: - Add Image Label
    @IBOutlet weak var addImageLabel: UILabel!
    
    // MARK: - Button
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Profile Image Add
    @IBOutlet weak var profileImage: UIImageView!
    
    // MARK: - Location Toggle
    @IBOutlet weak var locationToggleView: UISwitch!
    
    // MARK: - Properties
    private let viewModel = AddAnnotationViewModel()
    private lazy var gestureRecognizer = UITapGestureRecognizer()
    var latitude: Double?
    var longitude: Double?
    private let customBlackColor = UIColor(named: "BackgroundColor")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureImage()
    }

    private func setupUI() {
        title = "Profile"
        view.backgroundColor = customBlackColor
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        navigationController?.navigationItem.hidesBackButton = true
        
        // MARK: - Add Image Label
        let gestureRecognizerForLabel = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        addImageLabel.text = "Add Image"
        addImageLabel.isUserInteractionEnabled = true
        addImageLabel.addGestureRecognizer(gestureRecognizerForLabel)

        
        // MARK: - SaveButton UI
        saveButton.setTitle("Save", for: .normal)
        
        // MARK: - UsernameTextField UI
        let attributedStringForNameTextField = NSAttributedString(string: "John Patric", attributes: [
            .foregroundColor: UIColor.white.withAlphaComponent(0.5)
        ])
        
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.backgroundColor = customBlackColor
        usernameTextField.attributedPlaceholder = attributedStringForNameTextField
        usernameTextField.layer.borderWidth = 0.4
        usernameTextField.layer.cornerRadius = 5
        usernameTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        usernameTextField.textColor = .white.withAlphaComponent(0.8)
        usernameTextField.keyboardAppearance = .dark
        
        // MARK: - UserTitleTextField
        let attributedStringForTitleTextField = NSAttributedString(string: "iOS Developer", attributes: [
            .foregroundColor: UIColor.white.withAlphaComponent(0.5)
        ])
        
        userTitleTextField.borderStyle = .roundedRect
        userTitleTextField.backgroundColor = customBlackColor
        userTitleTextField.textColor = .white.withAlphaComponent(0.8)
        userTitleTextField.attributedPlaceholder = attributedStringForTitleTextField
        userTitleTextField.layer.borderWidth = 0.4
        userTitleTextField.layer.cornerRadius = 5
        userTitleTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        userTitleTextField.keyboardAppearance = .dark
    }
    
    private func configureImage() {
        profileImage.isUserInteractionEnabled = true
        profileImage.setRounded()
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

    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        DispatchQueue.main.async {
            self.profileImage.image = UIImage(named: "addProfileImage")
            self.usernameTextField.text = ""
            self.userTitleTextField.text = ""
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        print("Worked")
//        let name = usernameTextField.text!
//        let title = usernameTextField.text!
//        let image = profileImage.image?.jpegData(compressionQuality: 50)
//        let status = status
//        let location = Location(latitude: latitude!, longitude: longitude!)
//        let user = User(name: name, title: title, image: image!, status: status, location: location)
//        
//        viewModel.saveUserInfo(user: user)
    }
    
    
    @IBAction func locationToggle(_ sender: Any) {
        if locationToggleView.isOn {
            DispatchQueue.main.async {
                self.toggleLabel.text = Constants.online.rawValue
                
            }
        } else {
            DispatchQueue.main.async {
                self.toggleLabel.text = Constants.offline.rawValue
                self.toggleLabel.textColor = .gray.withAlphaComponent(0.7)
            }
        }
    }
    
    @objc private func closeKeyboard() {
        self.view.endEditing(true)
    }
}

extension AddAnnotationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImage.image = info[.originalImage] as? UIImage
        profileImage.contentMode = .scaleAspectFill
        profileImage.setRounded()
        self.addImageLabel.text = Constants.editImage.rawValue
        self.dismiss(animated: true)
    }
}
