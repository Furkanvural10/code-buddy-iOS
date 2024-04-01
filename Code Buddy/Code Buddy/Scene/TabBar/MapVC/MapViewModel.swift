import Foundation

protocol MapViewControllerDelegate: AnyObject {
    func showSuccessAlertMessage()
    func showErrorAlertMessage()
}

protocol MapViewModelProtocol {
    
    // MARK: - Functions
    func getUsers()
    func sendNotification()
    func saveNotificationToDatabase(data: NotificationModel)
    
    // MARK: - Properties
    var users: [User] { get }
    
}

final class MapViewModel {
    var users = [User]()
    weak var delegate: MapViewControllerDelegate?
}

extension MapViewModel: MapViewModelProtocol {
    
    // Go DB get user and fill user list
    func getUsers() {
        
    }
    
    func sendNotification() {
        // One signal setup...
    }
    
    func saveNotificationToDatabase(data: NotificationModel) {
        FirebaseManager.shared.addDataToDB(collection: "Notification", secondCollection: "All Notification", document: data.receiverID, data: data) { result in
            switch result {
            case .success(_):
                self.delegate?.showSuccessAlertMessage()
            case .failure(_):
                self.delegate?.showErrorAlertMessage()
            }
        }
    }
}
