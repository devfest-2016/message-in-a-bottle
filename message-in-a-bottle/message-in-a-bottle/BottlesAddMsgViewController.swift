//
//  BottlesAddMsgViewController.swift
//  message-in-a-bottle
//
//  Created by Dave Neff on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import FirebaseAuth
class BottlesAddMsgViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!

    @IBOutlet weak var messageTextField: UITextView!
    
    var oceanName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }



    @IBAction func sendButtonAction(_ sender: UIButton) {
        if messageTextField.text == "" {
//            let alert
        } else {
            FirebaseMethods.createNewBottle(uniqueID: (FIRAuth.auth()?.currentUser?.uid)!, oceanID: oceanName, title: "", messageContent: messageTextField.text)
            dismiss(animated: true, completion: { 
                
            })
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true) {
            
        }
    }
    
    
}
