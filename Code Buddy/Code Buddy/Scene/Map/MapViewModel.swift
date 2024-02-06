import Foundation

protocol MapViewModelProtocol {
    
    func getUsers()
    func addUserAnnotation()
    func updateUserAnnotation()
    func deleteUserAnnotation()
    
    var users: [User] { get }
}

final class MapViewModel {
    
    var users = [User]()
    
}

extension MapViewModel: MapViewModelProtocol {
    
    func getUsers() {
        // GO DB get user!!
        
    }
    
    func addUserAnnotation() {
        // GO DB add user annotation
    }
    
    func updateUserAnnotation() {
        // GO DB update user annotation
    }
    
    func deleteUserAnnotation() {
        // GO DB delete user annotation from appdelegate
    }
}
