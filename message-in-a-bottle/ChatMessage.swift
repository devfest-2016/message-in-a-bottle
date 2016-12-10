//
//  ChatMessage.swift
//  message-in-a-bottle
//
//  Created by Benjamin Su on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class ChatMessage {
    
    var messageID: String
    var senderUniqueKey: String
    var content: String
    var timestamp: Double
    var dateSent: Date
    var senderName: String
    
    init(senderName: String, messageID: String, senderUniqueKey: String, content: String, timestamp: Double) {
        self.messageID = messageID
        self.senderUniqueKey = senderUniqueKey
        self.content = content
        self.timestamp = timestamp
        self.dateSent = Date(timeIntervalSince1970: timestamp)
        self.senderName = senderName
    }
    
}
