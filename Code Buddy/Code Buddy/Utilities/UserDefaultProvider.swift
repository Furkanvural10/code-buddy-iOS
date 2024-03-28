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
    }
    
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
