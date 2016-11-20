

import Foundation
import Firebase


class FirebaseMethods {
    
    
    //MARK: - Sign Up & Log In Funcs
    
    static func signInButton(email: String, password: String) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                
            }
        }
    }
    
    
    static func signUpButton(email: String, password: String, firstName: String, lastName: String) {
        
        let ref = FIRDatabase.database().reference().root
        
        if email != "" && password != "" {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    let userDictionary = ["email": email, "firstName": firstName, "lastName": lastName, "uniqueKey": (user?.uid)!]
                    
                    ref.child("users").child((user?.uid)!).setValue(userDictionary)
                    
                } else {
                    print(error?.localizedDescription ?? "")
                }
                
                
            })
        }
    }
    
    
    // MARK: - Create new bottle message
    
    
    static func createNewBottle(uniqueID: String, oceanID: String, title: String, messageContent: String) {
        
        let ref = FIRDatabase.database().reference().root
        
        let messageDictionary = ["uniqueKey": uniqueID, "title": title, "messageContent": messageContent, "timestamp": String(describing: Date().timeIntervalSince1970)]
        let messageID = ref.childByAutoId().key
        
        ref.child("bottles").child(oceanID).child(messageID).updateChildValues(messageDictionary)
        ref.child("users").child(uniqueID).child("bottles").updateChildValues([messageID:oceanID])
        
    }
    
    // MARK: - Pull all bottles for user
    
    static func retrieveBottlesForUser(uniqueID: String, completion: @escaping ([Message]) -> Void) {
        let userRef = FIRDatabase.database().reference().child("users").child(uniqueID).child("bottles")
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            var userMessages = [Message]()
            
            print("PROGRESS: retrieving from \(userRef)")
            
            guard let messagesRaw = snapshot.value else { print("FAILURE: snapshot.value has no value for specific user messages"); return }
            
            print("PROGRESS: messagesRaw: \(messagesRaw)")
            
            guard let messages = messagesRaw as? [String:Any] else { print("FAILURE: messagesRaw cannot be converted to messages"); return }
            
            print("FINDME: \(messages.count)")
            
            for message in messages {
                let messageID = message.key
                print("FINDME: \(messageID)")
                guard let oceanID = message.value as? String else { print("FAILURE: message.value has no value"); return }
                
                FirebaseMethods.retrieveBottle(messageID: messageID, oceanID: oceanID, completion: { (message) in
                    userMessages.append(message)
                    print("FINDME: \(userMessages.count)>\(messages.count)")
                    if userMessages.count == messages.count {
                        completion(userMessages)
                    }
                })
            }
        })
        
        
    }
    private static func retrieveBottle(messageID: String, oceanID: String, completion: @escaping (Message)->Void){
        print("FINDME: \(messageID) function")
        
        let bottleRef = FIRDatabase.database().reference().child("bottles").child(oceanID).child(messageID)
        
        print("FINDME: \(bottleRef)")
        
        print(bottleRef)
        bottleRef.observeSingleEvent(of: .value, with: { (snapshot) in

            guard let messageInfo = snapshot.value as? [String: Any] else { print("FAILURE: snapshot.value has no value for ocean value \(oceanID)"); return }
        
            print("FINDME: observing \(messageID)")

            
            guard
                let userUniqueKey = messageInfo["uniqueKey"] as? String,
                let title = messageInfo["title"] as? String,

                let body = messageInfo["body"] as? String,
                let timestamp = messageInfo["timestamp"] as? Double
                else { print("FAILURE: Data unavailable in messageInfo");return }
                

            
            let message = Message(messageUniqueID: messageID, title: title, body: body, userUniqueKey: userUniqueKey, timestamp: timestamp)
            message.setUser {
                print("FINDME: adding user \(messageID)")
                completion(message)
            }
        })
    }
    
    // MARK: - Create chat room
    
    
    static func createChatRoomForUsers(userOne: User, userTwo: User) {
        
        let ref = FIRDatabase.database().reference().root
        
        let chatID = ref.childByAutoId().key
        
        
        let userOneDictionary = ["recipientUniqueID": userTwo.uniqueKey, "recipientName": userTwo.name]
        let userTwoDictionary = ["recipientUniqueID": userOne.uniqueKey, "recipientName": userOne.name]
        
        ref.child("users").child(userOne.uniqueKey).child("chats").setValue(userOneDictionary, forKey: chatID)
        
        ref.child("users").child(userTwo.uniqueKey).child("chats").setValue(userTwoDictionary, forKey: chatID)
        
        ref.child("chats").setValue(["previousMessage": "Be the first to start a conversation!", "timestamp": String(describing: Date().timeIntervalSince1970)], forKey: chatID)
        
        
        ref.setValue(chatID, forKey: "chatMessages")
        
    }
    
    
    static func sendMessage(sender: User, messageContent: String, chatID: String) {
        
        let ref = FIRDatabase.database().reference().root
        let timeStamp = Date().timeIntervalSince1970.description
        
        let messageID = ref.childByAutoId().key
        
        ref.child("chats").setValue(["previousMessage": messageContent, "timestamp": timeStamp], forKey: chatID)
        
        ref.child("chatMessages").child(chatID).setValue(["senderName": sender.name, "senderUniqueKey": sender.uniqueKey, "messageContent": messageContent, "timestamp": timeStamp] , forKey: messageID)
        
        
        
        
    }
    
    
    // MARK: - Delete chat
    
    static func removeUserFromChat(chatID: String, messageID: String) {
        
        
        let ref = FIRDatabase.database().reference().root
        let currentUser = FIRAuth.auth()?.currentUser?.uid
        
        
        ref.child("users").child(currentUser!).child("chats").observeSingleEvent(of: .value, with: { snapshot in
            
            if let chatSnapshot = snapshot.value as? [String: Any] {
                for item in chatSnapshot {
                    
                    if item.key == chatID {
                        
                        ref.child("users").child(currentUser!).child("chats").removeValue()
                        ref.child("chats").child(chatID).removeValue()
                        ref.child("chatMessages").child(chatID).child(messageID).removeValue()
                        
                        guard let secondUserUniqueKey = item.value as? String else {return}
                        ref.child("users").child(secondUserUniqueKey).child("chats").child(messageID).removeValue()
                        
                    }
                }
            }
            
        })
        
    }
    
    //MARK: - Retrieve Messages for Ocean
    
    static func retrieveMessages(for ocean: Ocean, completion: @escaping ([Message]) -> Void) {
        let oceanRef = FIRDatabase.database().reference().child("oceans").child(ocean.name)
        
        oceanRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let oceanInfoRaw = snapshot.value as? [String:Any]
            var messages = [Message]()
            
            guard let oceanInfo = oceanInfoRaw else { return }
            
            for (messageUniqueID, message) in oceanInfo {
                let messageInfoRaw = message as? [String:Any]
                
                guard
                    let messageInfo = messageInfoRaw as? [String:String],
                    let title = messageInfo["title"],
                    let body = messageInfo["body"],
                    let userUniqueKey = messageInfo["userUniqueKey"],
                    let timestampString = messageInfo["title"],
                    let timestamp = Double(timestampString)
                    else { return }
                
                
                let message = Message(messageUniqueID: messageUniqueID, title: title, body: body, userUniqueKey: userUniqueKey, timestamp: timestamp)
                messages.append(message)
            }
            
            completion(messages)
        })
    }
    
    
    static func deleteMessage(from ocean: Ocean) {
        let oceanRef = FIRDatabase.database().reference().child("oceans").child(ocean.name)
        
        oceanRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let oceanInfoRaw = snapshot.value as? [String: Any] else {return}
            guard let acceptedMessageID = ocean.acceptedMessageID else {return}
            
            
            for item in oceanInfoRaw {
                if item.key == acceptedMessageID {
                    oceanRef.child("chatMessages").child(acceptedMessageID).removeValue()
                }
            }
        })
        
    }
    
    
    static func retrieveChatMessages(for userID: String, chatID: String, with completion: @escaping ([ChatMessage]) -> Void) {
        let chatRef = FIRDatabase.database().reference().child("chatMessages").child(chatID)
        var chatMessages = [ChatMessage]()
        
        chatRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let chatInfoRaw = snapshot.value as? [String:Any] else {return}

            for (chatMessageUniqueID, chatMessage) in chatInfoRaw {
                guard let chatInfo = chatMessage as? [String:Any] else {return}
                let messageID = chatMessageUniqueID

                guard let senderName = chatInfo["senderName"] as? String,
                    let senderUniqueKey = chatInfo["senderUniqueKey"] as? String,
                    let content = chatInfo["messageContent"] as? String,
                    let timestamp = chatInfo["timeStampString"] as? Double
                    else {return}
                print("SENDER: \(senderName)")
                print("senderUniqueKey: \(senderUniqueKey)")
                print("content: \(content)")
                print("timestamp: \(timestamp)")
                
                let chatMessageToAppend = ChatMessage(senderName: senderName, messageID: messageID, senderUniqueKey: senderUniqueKey, content: content, timestamp: timestamp)
                print(chatMessageToAppend)
                chatMessages.append(chatMessageToAppend)
                
            }
            
                completion(chatMessages)
        })
    }
    
    
    static func retrieveChatRooms(for userID: String, with completion: @escaping ([Chatroom]) -> Void) {
        let chatRef = FIRDatabase.database().reference().child("users").child(userID)
        
        chatRef.observeSingleEvent(of: .value, with: { (snapshot) in
            print("SNAPSHOT INSIDE RETRIEVE: \(snapshot.value)")
            var chatRoomArray = [Chatroom]()
            guard let chatroomRaw = snapshot.value as? [String:Any] else {return}
            
            guard let chats = chatroomRaw["chats"] as? [String: Any] else {return}
            print("CHATS INSIDE RETRIEVE: \(chats)\n\n\n")
            
            for chat in chats {
                print("CHAT: \(chat.key)")
                print("user: \(userID)")
        
                let chatID = chat.key
                guard let parterNameString = chat.value as? String else {return}
                
                retrieveChatMessages(for: userID, chatID: chatID, with: { (chatMessages) in
                    
                    for chat in chatMessages {
                        let lastMessage = chat.content
                        let timestamp = chat.timestamp
                        
                        let chatroom = Chatroom(chatID: chatID, timestamp: timestamp, lastMessage: lastMessage, partnerName: parterNameString)
                        chatRoomArray.append(chatroom)
                        print("CHATROOM MADE: \(chatroom.chatID)")
                    }
                    
                    print("CHATROOMARRAY COUNT: \(chatRoomArray.count)")
                    completion(chatRoomArray)

                })

            }

        })
        
        
    }
    
    
    /*
     Sending data TO Firebase:
     
     1. func to add 2 users to specific chat
     
     2. func to remove user from specific chat
     
     3. create new user
     
     4. create new chat
     
     5. add message to chat
     
     6. create bottle message for specific ocean
     
     */
    
    
    /*
     Retreiving data FROM Firebase:
     
     1. append messages for each user to [Message]() that will be dislpayed on table view
     
     2. append messages to [Message]() in ocean in tableView
     
     3. retreive user info of given user / self
     
     
     */
    
    
    
}


