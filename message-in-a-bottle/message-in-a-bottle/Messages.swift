

import Foundation

class Message {
    
    var messageUniqueID: String
    var title: String
    var body: String
    let timestamp: Double
    let dateSent: Date
    var from: User?
    
    init(messageUniqueID: String, title: String, body: String, userUniqueKey: String, timestamp: Double) {
        self.messageUniqueID = messageUniqueID
        self.title = title
        self.body = body
        
        self.timestamp = timestamp
        self.dateSent = Date(timeIntervalSince1970: timestamp)
        
        User.retrieveUser(with: userUniqueKey) { (retrievedUser) in
            if let retrievedUser = retrievedUser {
                self.from = retrievedUser
            } else {
                self.from = nil
            }
        }
    }
    
}
