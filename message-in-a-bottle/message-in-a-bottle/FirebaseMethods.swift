

import Foundation
import Firebase


class FirebaseMethods {

    
    //MARK: - Sign Up & Log In Funcs
    
    static func signInButton(email: String, password: String) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                
            }
            guard let user = FIRAuth.auth()?.currentUser else { print("error"); return }
            //            FIRAuth.auth()?.currentUser?.uid
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
    
    
    static func createNewBottle(uniqueID: String, oceanID: String, messageContent: String) {
        
        let ref = FIRDatabase.database().reference().root
        
        let messageDictionary = ["uniqueKey": uniqueID, "messageContent": messageContent, "timestamp": String(describing: Date().timeIntervalSince1970)]
        let messageID = ref.childByAutoId().key
        
        ref.child("bottle").child(oceanID).setValue(messageDictionary, forKey: messageID)
        ref.child("users").child(uniqueID).child("bottles").child(messageID).setValue("true")
        
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
    
    
    static func retrieveChatMessages(for user: User, chatID: String, with completion: @escaping ([ChatMessage]) -> Void) {
        let chatRef = FIRDatabase.database().reference().child("users").child(user.uniqueKey).child("chats").child(chatID)
        
        chatRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let chatInfoRaw = snapshot.value as? [String:Any]
            var chatMessages = [ChatMessage]()
            
            for (chatMessageUniqueID, chatMessage) in chatInfoRaw {
                let chatMessageInfoRaw = chatMessage as? [String:Any]
                
                guard
                    let chatInfo = chatMessageInfoRaw as? [String:String],
                    let senderName = chatInfo["senderName"],
                    let messageID = chatInfo["messageID"],
                    let senderUniqueKey = chatInfo["senderUniqueKey"],
                    let content = chatInfo["content"],
                    let timestampString = chatInfo["timeStampString"],
                    let timestamp = Double(timestampString)
                    else { return }
                
                let chatMessage = ChatMessage(senderName: senderName, messageID: messageID, senderUniqueKey: senderUniqueKey, content: content, timestamp: timestamp)
                chatMessages.append(chatMessage)
            }
            
            completion(chatMessages)
        })
    }

    
    static func retrieveChatRooms(for user: User, with completion: ([Chatroom]) -> Void) {
        let chatRef = FIRDatabase.database().reference().child("users").child(user.uniqueKey)
        
        chatRef.observeSingleEvent(of: .value) { (snapshot) in
            let chatRoomArray = [Chatroom]()
            let chatroomRaw = snapshot.value as? [String:Any]
            
            for (chatUniqueID, chat) in chatroomRaw {
                let chatroomInfoRaw = chat as? [String:Any]
                
                guard
                    let chatroomInfo = chatroomInfoInfoRaw as? [String:String],
                    let chatID = chatroomInfo["chatID"],
                    let lastMessage = chatroomInfo["lastMessage"],
                    let chatMessages = chatroomInfo["chatMessages"],
                    let partnerName = chatroomInfo["partnerName"],
                    let timestampString = chatroomInfo["timeStampString"],
                    let timestamp = Double(timestampString)
                    else { return }
                
                
                let chatroom = Chatroom(chatID: chatID, timestamp: timestamp, lastMessage: lastMessage, partnerName: partnerName)
                
                chatRoomArray.append(chatroom)
            
            }
        }
        
        completion(chatRoomArray)
        
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


