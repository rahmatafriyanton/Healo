//
//  Message.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 23/10/22.
//

import Foundation
import MessageKit

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
}
