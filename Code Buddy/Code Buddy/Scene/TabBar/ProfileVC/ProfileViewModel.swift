import Foundation
import UIKit
import CoreLocation

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
    let locationManager = LocationProvider.shared
    
    func saveUserInfo(user: User) {
        
        
        print("locationManager.longitude: \(locationManager.longitude)")
        print("locationManager.longitude: \(locationManager.latitude)")
//        print(locationManager.latitude)
//        print(locationManager.longitude)
        print(user.status)
        print(user.name)
        print(user.title)
        print(user.location.latitude)
        
        
    }
    
    func updateUserInfo(user: User) {
        // Kullanıcının konumunu vs güncelle
        
    }
    
    
}


