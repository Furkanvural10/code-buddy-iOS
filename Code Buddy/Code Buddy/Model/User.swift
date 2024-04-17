//
//  User.swift
//  Code Buddy
//
//  Created by furkan vural on 26.12.2023.
//

import Foundation

enum UserStatus: String, Codable {
    case offline = "Offline"
    case online = "Online"
}

struct User: Codable, Hashable {
    let name: String
    let title: String
    let status: UserStatus.RawValue
    let location: LocationModel
    let id: String
    var imageURL: String = ""
}
