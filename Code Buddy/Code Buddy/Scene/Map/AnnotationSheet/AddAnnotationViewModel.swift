import Foundation
import UIKit

protocol AddAnnotationViewModelProtocol {
    
    func saveUserInfo(user: User)
    func updateUserInfo(user: User)
    func updateStatus(index: Int)
    var statusChangedClosure: ((UIColor) -> Void)? { get } 
}

class AddAnnotationViewModel: AddAnnotationViewModelProtocol {
    
    var statusChangedClosure: ((UIColor) -> Void)?

    func saveUserInfo(user: User) {
        // Verileri db kaydet
        print("USER: \(user) ")
    }
    
    func updateUserInfo(user: User) {
        // Kullanıcının konumunu vs güncelle
    }
    
    func updateStatus(index: Int) {
        var color: UIColor = .systemRed
        
        switch index {
        case 0:
            color = .systemGreen
        case 1:
            color = .systemYellow
        default:
            color = .systemRed
        }
        
        statusChangedClosure?(color)
    }
}
