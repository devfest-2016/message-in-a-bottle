

import Foundation

class Message {
    
    var messageUniqueID: String
    var title: String
    var body: String
    let timestamp: Double
    let dateSent: Date
    var from: User?
    let userUniqueKey: String
    
    init(messageUniqueID: String, title: String, body: String, userUniqueKey: String, timestamp: Double) {
        self.messageUniqueID = messageUniqueID
        self.title = title
        self.body = body
        
        self.timestamp = timestamp
        self.dateSent = Date(timeIntervalSince1970: timestamp)
        
        self.userUniqueKey = userUniqueKey
    }
    
    func setUser(completion: @escaping ()-> Void) {
        User.retrieveUser(with: userUniqueKey) { (user) in
            self.from = user
            completion()
        }
    }
    
    
    
    
}
