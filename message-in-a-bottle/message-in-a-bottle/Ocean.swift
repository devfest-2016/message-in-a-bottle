

import Foundation
import Firebase

class Ocean {
    
    var name: String
    var messages = [Message]()
    var acceptedMessageID: String?

    
    init(name: String) {
        self.name = name
    }
    
    func saveMessages(with completion: @escaping () -> Void) {
        FirebaseMethods.retrieveMessages(for: self) { (messages) in
            self.messages = messages
            completion()
        }
    }
    
    func determineAcceptedMessage(with completion: @escaping () -> Void) {
        
        
        
    }
    
    static let oceanNames = [
    "Hospitality",
    "Technology",
    "Music",
    "Media",
    "Fasion",
    "Graphic Design",
    "Publishing",
    "Finance",
    "Government",
    "Education",
    ]
}



