

import Foundation
import Firebase

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

    
    static func retrieveUser(with uniqueID: String, completion: @escaping (User?)-> Void) {
        print("PROGRESS: Retreiving User Data")
        
        let userRef = FIRDatabase.database().reference().child("users").child(uniqueID)
        
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let userInfoRaw = snapshot.value as? [String:Any]
            
            guard
                let userInfo = userInfoRaw,
                let firstName = userInfo["firstName"] as?  String,
                let lastName = userInfo["lastName"] as? String,
                let email = userInfo["email"] as? String,
                let uniqueKey = userInfo["uniqueKey"] as? String
                else { print("\n\n\n\n\n\(userInfoRaw)\n\n\n\n"); return }
            
            print("Got user info: \(userInfo)")
            
            let user = User(firstName: firstName, lastName: lastName, email: email, uniqueKey: uniqueKey)
            completion(user)
        })
    }
    
}

var currentUser: User?
