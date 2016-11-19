

import Foundation
import Firebase

class Ocean {
    
    var name: String
    var messages = [Message]()
    
    init(name: String) {
        self.name = name
    }
    
    func saveMessages(with completion: @escaping () -> Void) {
        FirebaseMethods.retrieveMessages(for: self) { (messages) in
            self.messages = messages
            completion()
        }
    }
    
    
}

