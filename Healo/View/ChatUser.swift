//
//  ChatUser.swift
//  Healo
//
//  Created by Elvina Jacia on 19/10/22.
//

import UIKit

//struct ChatUser: Codable {
//    let id: Int
//    var profileIcon: String //receiver_icon
//    var username: String //receiver_name
//    var message: String //last_message
//    var sentTime: String //last_message_time
//    var numOfMesReceived: Int //unread_message
//    var chatStatus: String //session_status
//    var reflectStatus: Int //reflection_status
//    var roomID: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, username, message, profileIcon, sentTime, numOfMesReceived, chatStatus, reflectStatus, roomID
//    }
//}

struct ChatUser {
    let id: String
    var profileIcon: String //receiver_icon
    var username: String //receiver_name
    var message: String //last_message
    var sentTime: String //last_message_time
    var numOfMesReceived: Int //unread_message
    var chatStatus: String //session_status
    var reflectStatus: Int //reflection_status
    var roomID: String

}
