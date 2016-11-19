

import Foundation

class User {
    
    var firstName: String
    var lastName: String
    var uniqueKey: String
    var email: String
    
    var name: String { return "\(firstName) \(lastName)" }
    
    
    init(firstName: String, lastName: String, email: String, uniqueKey: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.uniqueKey = uniqueKey
        
    }
    
    
    
}
