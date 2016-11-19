//
//  ChatMessage.swift
//  message-in-a-bottle
//
//  Created by Benjamin Su on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class ChatMessage {
    
    var msgID: String
    var nameOfSender: String
    var content: String
    var timestamp: Double
    
    init(msgID: String, name: String, content: String, timestamp: Double) {
        self.msgID = msgID
        self.nameOfSender = name
        self.content = content
        self.timestamp = timestamp
    }
    
}
