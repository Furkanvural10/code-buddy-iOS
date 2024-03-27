import Foundation
import UIKit
import CoreLocation

protocol ProfileViewControllerDelegate: AnyObject {
    func showSuccessMessage()
    func showErrorMessage()
}

protocol ProfileViewModelProtocol {
    
    func saveUserInfo(user: User, imageData: Data)
    func updateUserInfo(user: User)
    
    // If user added annotation addAnnotationSheetView change update new location
    var isUserAddAnnotation: Bool { get }
    
    var allUser: [User] { get }
    
    
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    var isUserAddAnnotation: Bool = false
    var allUser: [User] = []
    
    weak var delegate: ProfileViewControllerDelegate?
    
    func saveUserInfo(user: User, imageData: Data) {
        
        FirebaseManager.shared.uploadImage(imageData: imageData, user: user) { error in
            switch error {
            case .success(let success):
                self.delegate?.showSuccessMessage()
            case .failure(let failure):
                self.delegate?.showErrorMessage()
            }
        }
        
        
    }
    
    func updateUserInfo(user: User) {
        // Kullanıcının konumunu vs güncelle
        
    }
    
    
}


