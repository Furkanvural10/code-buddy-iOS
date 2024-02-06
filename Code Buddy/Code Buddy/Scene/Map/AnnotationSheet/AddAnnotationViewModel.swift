import Foundation
import UIKit

protocol AddAnnotationViewModelProtocol {
    
    func saveUserInfo(user: User)
    func updateUserInfo(user: User)
    func updateStatus(index: Int)
    
    var statusChangedClosure: ((UIColor) -> Void)? { get }
    
    // If user added annotation addAnnotationSheetView change update new location
    var isUserAddAnnotation: Bool { get }
    
    
}

final class AddAnnotationViewModel: AddAnnotationViewModelProtocol {
    
    var statusChangedClosure: ((UIColor) -> Void)?
    var isUserAddAnnotation: Bool = false

    func saveUserInfo(user: User) {
        guard user.name.count > 3,
              user.title.count > 2 else { return }
        
        print("User Info: \(user.image) ")
        
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
