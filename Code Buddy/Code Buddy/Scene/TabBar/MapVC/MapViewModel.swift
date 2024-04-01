import Foundation

protocol MapViewControllerDelegate: AnyObject {
    func showSuccessAlertMessage(title: String, message: String)
    func showErrorAlertMessage(title: String, message: String)
}

protocol MapViewModelProtocol {
    
    // MARK: - Properties
    var users: [User] { get }
    
    // MARK: - Functions
    func getUsers()
    func sendNotification()
    func saveNotificationToDatabase(data: NotificationModel)
    
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
                self.delegate?.showSuccessAlertMessage(title: "Firebase Succ", message: "Succ Message 2")
            case .failure(_):
                self.delegate?.showErrorAlertMessage(title: "Firebase Err", message: "Err 2")
            }
        }
    }
    
    func checkUserProfileCrated(receiverID: String) {
        let user = UserDefaultProvider.shared.getUserInformation()
        guard let user else {
            delegate?.showErrorAlertMessage(title: "Profile Error", message: "Error message")
            return
        }
        let notificationModel = NotificationModel(receiverID: receiverID, senderID: user.id, senderImageURL: user.imageURL , senderName: user.name, isWaitingResponse: true)
        saveNotificationToDatabase(data: notificationModel)
    }
}
