import Foundation
import UIKit

protocol ProfileViewModelProtocol {
    
    func saveUserInfo(user: User)
    func updateUserInfo(user: User)
    
    // If user added annotation addAnnotationSheetView change update new location
    var isUserAddAnnotation: Bool { get }
    
    var allUser: [User] { get }
    
    
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    var isUserAddAnnotation: Bool = false
    var allUser: [User] = []

    func saveUserInfo(user: User) {
        
        // Fixed validation class!
        guard user.name.count > 3,
              user.title.count > 2 else { return }
        
        print("User Info: \(user.image) ")
        
        
    }
    
    func updateUserInfo(user: User) {
        // Kullanıcının konumunu vs güncelle
        
        
    }
    
}
