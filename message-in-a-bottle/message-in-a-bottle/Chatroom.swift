//
//  Chatrooms.swift
//  message-in-a-bottle
//
//  Created by Benjamin Su on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class Chatroom {
    
    var chatID: String
    var chatMessages: [ChatMessage]
    var timestamp: Double
    
    init(chatID: String, chatMessages: [ChatMessage], timestamp: Double) {
        self.chatID = chatID
        self.chatMessages = chatMessages
        self.timestamp = timestamp
    }
    
}
