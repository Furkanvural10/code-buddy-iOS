//
//  UserDefaultProvider.swift
//  Code Buddy
//
//  Created by furkan vural on 28.03.2024.
//

import Foundation

protocol UserDefaultsProvidable {
    func saveUserInformation(user: User)
}

final class UserDefaultProvider {
    
    static let shared = UserDefaultProvider()
    private let userDefaults = UserDefaults.standard
    private init() {}

}

extension UserDefaultProvider: UserDefaultsProvidable {
    func saveUserInformation(user: User) {
        userDefaults.set(user.name, forKey: "userName")
        userDefaults.set(user.title, forKey: "userTitle")
        userDefaults.set(user.status, forKey: "status")
        userDefaults.set(user.id, forKey: "userID")
    }
    
    
    /**
     Fetches user information from UserDefaults and returns a User object if all required fields are present.

     - Returns: An optional User object containing user information if all required fields are found in UserDefaults. If any required field is missing, returns nil.

     - Note: The function retrieves user information from UserDefaults using the following keys:
        - "userName": User's name as a String.
        - "userTitle": User's title as a String.
        - "userImageURL": URL string for the user's profile image.
        - "status": User's status message as a String.

     - Important: Ensure that all required fields are set in UserDefaults before calling this function, otherwise it will return nil.
    */
    func getUserInformation() -> User? {
        guard let name = userDefaults.object(forKey: "userName") as? String,
              let title = userDefaults.object(forKey: "userTitle") as? String,
              let imageURL = userDefaults.object(forKey: "userImageURL") as? String,
              let status = userDefaults.object(forKey: "status") as? String else {
            return nil
        }
        
        return User(
            name: name,
            title: title,
            status: status,
            location: LocationModel(latitude: 0.0, longitude: 0.0),
            id: "",
            imageURL: imageURL
        )
        
    }
}
