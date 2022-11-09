//
//  MessageForChatDetail.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 07/11/22.
//

import Foundation

struct MessageForSendChat: Codable {
    let messageID: String
    let senderID: Int
    let roomID, message: String

    enum CodingKeys: String, CodingKey {
        case messageID = "message_id"
        case senderID = "sender_id"
        case roomID = "room_id"
        case message
    }
}
