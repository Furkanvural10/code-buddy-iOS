import Foundation

protocol MapViewModelProtocol {
    
    func getUsers()
    var users: [User] { get }
}

final class MapViewModel {
    
    var users = [User]()
    
}

extension MapViewModel: MapViewModelProtocol {
    
    func getUsers() {
        // GO DB get user and fill user list
    
    }
    
}
