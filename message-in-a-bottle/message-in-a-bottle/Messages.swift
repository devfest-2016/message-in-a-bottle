

import Foundation

class Message {
    
    var title: String
    var body: String
    var postedAt: Date
    var from: User
    var userUniqueKey: String
    var timestamp: Double
    
    init(title: String, body: String, postedAt: Date, from: User, userUniqueKey: String, timestamp: Double) {
        self.title = title
        self.body = body
        self.postedAt = postedAt
        self.from = from
        self.userUniqueKey = userUniqueKey
        self.timestamp = timestamp
    }
    
}
