//
//  Notification.swift
//  Code Buddy
//
//  Created by furkan vural on 29.03.2024.
//

import Foundation

struct NotificationModel: Codable {
    
    let receiverID: String
    let senderID: String
    let senderImageURL: String
    let senderName: String
    let isWaitingResponse: Bool
    
}
