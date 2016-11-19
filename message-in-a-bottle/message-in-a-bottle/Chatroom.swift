//
//  Chatrooms.swift
//  message-in-a-bottle
//
//  Created by Benjamin Su on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Chatroom {
    
    var chatID: String
    var lastMessage: String
    var timestamp: Double
    var dateSent: Date
    var partnerName: String
    
    var chatMessages = [ChatMessage]()
    var partner: User?
    var title: String?
    
    init(chatID: String, timestamp: Double, lastMessage: String, partnerName: String) {
        self.chatID = chatID
        self.lastMessage = lastMessage
        self.timestamp = timestamp
        self.dateSent = Date(timeIntervalSince1970: timestamp)
        self.partnerName = partnerName
        self.title = "Chat with \(partnerName)"
    }
    
    func retrievePartner(with completion: @escaping ()->Void) {
        User.retrieveUser(with: chatID) { (user) in
            self.partner = user
            completion()
        }
    }
    func retrieveMessages(with completion: @escaping ()->Void) {
        FirebaseMethods.retrieveChatMessages(chatID: chatID) { (chatMessages) in
            self.chatMessages = chatMessages
            completion()
        }
    }
    
}

extension FirebaseMethods {
    static func retrieveChatMessages(chatID: String, completion: @escaping ([ChatMessage]) -> Void) {
        let messagesRef = FIRDatabase.database().reference().child("chatMessages").child(chatID)
        
        messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let messagesPull = snapshot.value as? [String: Any]  else { return }
            
            var messages = [ChatMessage]()
            
            for messagePull in messagesPull {
                let messageID = messagePull.key
                if let messageInfo = messagePull.value as? [String: String] {
                    guard
                        let senderName = messageInfo["senderName"],
                        let senderUniqueKey = messageInfo["senderUniqueKey"],
                        let content = messageInfo["messageContent"],
                        let timestampString = messageInfo["timestamp"],
                        let timestamp = Double(timestampString)
                        else { return }
                        
                    
                    let message = ChatMessage(senderName: senderName, messageID: messageID, senderUniqueKey: senderUniqueKey, content: content, timestamp: timestamp)
                    messages.append(message)
                }
            }
            
            completion(messages)
        })
    }
}
