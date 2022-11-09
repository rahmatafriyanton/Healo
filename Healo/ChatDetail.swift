//
//  ChatDetail.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 07/11/22.
//

import Foundation

struct ChatDetail: Codable {
    let roomID, preflection: String
    let preflectionTime: String?
    let postflection: String
    let postflectionTime: String?
    let roomStatus: String
    let roomClosedBy: Int?
    let roomClosedReason, seekerMoodCheckout: String?
    let createdAt, updatedAt: String
    let seeker, healer: UserForChat
    let messages: [MessageForChat]?
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
        case messages
        case numberOfUnread = "number_of_unread"
    }
}
