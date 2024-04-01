import UIKit

final class MessageSheetViewController: UIViewController {

    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    private let messageIcon = UIImageView()
    private let messageTitle = UILabel()
    private let informationTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        setupSheetPresentationConfig()
    }
    
    func configure(title: String, message: String, color: UIColor, iconName: String) {
        DispatchQueue.main.async {
            self.messageTitle.text = title
            self.informationTitle.text = message
            self.messageIcon.image = UIImage(systemName: iconName)?.withTintColor(.white)
            self.view.backgroundColor = color
        }
        createUI()
        
    }
    
    private func createUI() {
        
        // MARK: - Icon View
        
        view.addSubview(messageIcon)
        messageIcon.tintColor = .black
        messageIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        // MARK: - Message Title
        messageTitle.textColor = .black
        messageTitle.font = .boldSystemFont(ofSize: 25)
        view.addSubview(messageTitle)
        messageTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(messageIcon.snp.bottom).offset(20)
        }
        
        // MARK: - Information Title Title
        informationTitle.textColor = .black
        view.addSubview(informationTitle)
        informationTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(messageTitle.snp.bottom).offset(10)
        }

    }
    
    private func setupSheetPresentationConfig() {
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [.custom(resolver: { context in
            0.25 * context.maximumDetentValue
        })]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.dismiss(animated: true)
        }
   
    }

}

extension MessageSheetViewController: UISheetPresentationControllerDelegate {}
