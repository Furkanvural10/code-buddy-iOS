//
//  User.swift
//  Code Buddy
//
//  Created by furkan vural on 26.12.2023.
//

import Foundation

struct User {
    
    enum UserStatus: String {
        case working = "Working"
        case networking = "Networking"
        case busy = "Busy"
    }
    
    let name: String
    let title: String
    let image: Data
    let status: UserStatus.RawValue
    let location: Location
}
