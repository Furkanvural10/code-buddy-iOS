import Foundation
import FirebaseFirestore

protocol MapViewControllerDelegate: AnyObject {
    func showSuccessAlertMessage(title: String, message: String)
    func showErrorAlertMessage(title: String, message: String)
    func showUser(allUsers: [User])
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
    private var firebase = FirebaseManager.shared
}

extension MapViewModel: MapViewModelProtocol {
    
    // Go DB get user and fill user list
    func getUsers() {
        
        let query = Firestore.firestore().collection("Users").whereField("status", isEqualTo: "Online")

        Task {
            do {
                let result = await firebase.getAllUser(of: User.self, with: query)
                switch result {
                case .success(let success):
                    print(success.map({ $0.name }))
                    users = success
                    delegate?.showUser(allUsers: users)
                case .failure(let failure):
                    print("-------")
                }
            }
        }
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
