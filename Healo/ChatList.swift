//
//  ChatList.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 07/11/22.
//

import Foundation

// MARK: - Welcome
struct ChatList: Codable {
    let roomID, preflection: String
    let preflectionTime: String?
    let postflection: String
    let postflectionTime: String?
    let roomStatus: String
    let roomClosedBy, roomClosedReason, seekerMoodCheckout: String?
    let createdAt, updatedAt: String
    let seeker, healer: UserForChat
    let lastMessage: MessageForChat
    let numberOfUnread: Int

    enum CodingKeys: String, CodingKey {
        case roomID = "room_id"
        case preflection
        case preflectionTime = "preflection_time"
        case postflection
        case postflectionTime = "postflection_time"
        case roomStatus = "room_status"
        case roomClosedBy = "room_closed_by"
        case roomClosedReason = "room_closed_reason"
        case seekerMoodCheckout = "seeker_mood_checkout"
        case createdAt, updatedAt, seeker, healer
        case lastMessage = "last_message"
        case numberOfUnread = "number_of_unread"
    }
}

// MARK: - Healer
struct UserForChat: Codable {
    let userID: Int
    let userName, userEmail, userGender: String
    let age: Int
    let profilePict: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case userEmail = "user_email"
        case userGender = "user_gender"
        case age
        case profilePict = "profile_pict"
    }
}

// MARK: - LastMessage
struct MessageForChat: Codable {
    let messageID, roomID: String
    let senderID: Int
    let message: String
    let messageStatus: Int
    let createdAt, updatedAt, status: String

    enum CodingKeys: String, CodingKey {
        case messageID = "message_id"
        case roomID = "room_id"
        case senderID = "sender_id"
        case message
        case messageStatus = "message_status"
        case createdAt, updatedAt, status
    }
}
