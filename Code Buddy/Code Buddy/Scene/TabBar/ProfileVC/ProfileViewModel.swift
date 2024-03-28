import Foundation
import UIKit
import CoreLocation

protocol ProfileViewControllerDelegate: AnyObject {
    func showSuccessMessage()
    func showErrorMessage()
    func showSavedUserData(user: User)
}

protocol ProfileViewModelProtocol {
    
    func saveUserInformationToCloud(user: User, imageData: Data)
    func saveUserInformationToLocal(user: User)

}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    weak var delegate: ProfileViewControllerDelegate?
    
    func saveUserInformationToCloud(user: User, imageData: Data) {
        
        FirebaseManager.shared.uploadImage(imageData: imageData, user: user) { error in
            switch error {
            case .success(_):
                self.delegate?.showSuccessMessage()
            case .failure(_):
                self.delegate?.showErrorMessage()
            }
        }
    }
    
    func saveUserInformationToLocal(user: User) {
        UserDefaultProvider.shared.saveUserInformation(user: user)
    }
    
    func getUserInformation() {
        let user = UserDefaultProvider.shared.getUserInformation()
        guard let user else { return }
        delegate?.showSavedUserData(user: user)
    }
}


