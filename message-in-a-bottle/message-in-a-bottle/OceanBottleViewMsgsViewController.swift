//
//  OceanBottleViewMsgsViewController.swift
//  message-in-a-bottle
//
//  Created by Benjamin Su on 11/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import FirebaseAuth
class OceanBottleViewMsgsViewController: UIViewController {

    var message: Message!
    
    @IBOutlet weak var titleTextLabel: UILabel!
    
    @IBOutlet weak var messageTextField: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextLabel.text = message.title
        messageTextField.text = message.body
        
    }

    @IBAction func acceptButtonAction(_ sender: UIButton) {
        
        User.retrieveUser(with: (FIRAuth.auth()?.currentUser?.uid)!) { (user) in
            let userOne = user!
            
            User.retrieveUser(with: self.message.userUniqueKey, completion: { (user) in
                let userTwo = user!
                
                FirebaseMethods.createChatRoomForUsers(userOne: userOne, userTwo: userTwo)
                self.dismiss(animated: true, completion: {
                    
                })
            })
        }
        
    }
   
    @IBAction func returnBottleButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: {
        
        })
    }

   

}
