import Foundation


protocol UserSheetViewModelProtocol {
    var allUser: [User] { get }
}


final class UserSheetViewModel {
        
    var allUser = [User]() // All User fetch AddAnnotationViewModel. get user from there
}

extension UserSheetViewModel: UserSheetViewModelProtocol {
    
}
