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
    
    var oceanName = ""
    
    let backgroundImage = UIImageView()
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextView!
    
    // Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // Button actions
    @IBAction func sendButtonAction(_ sender: UIButton) {
        if messageTextField.text != "" && titleTextField.text != ""{
            
            FirebaseMethods.createNewBottle(uniqueID: (FIRAuth.auth()?.currentUser?.uid)!, oceanID: oceanName, title: titleTextField.text!, messageContent: messageTextField.text)
            dismiss(animated: true, completion: {
                
            })
            
        } else if messageTextField.text != "" {
            
            let alert = createAlertWith(title: "Ahoy!", message: "A title would be nice.")
            self.present(alert, animated: true, completion: nil)
            
        } else if titleTextField.text != "" {
            
            let alert = createAlertWith(title: "Woah!", message: "You didn't write a message.")
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            let alert = createAlertWith(title: "Eh", message: "Throwing empty bottles are bad for the environment.")
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true) {
        }
    }
    
    func createAlertWith(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Sure Can Do", style: UIAlertActionStyle.cancel, handler: nil))
        return alert
    }
    
    // Setup view
    func setupView() {
        // Add background
        self.view.insertSubview(backgroundImage, at: 0)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = self.view.frame
        
        // Add background blur
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        backgroundImage.addSubview(blurEffectView)
        
        // Text field rounded corners
        messageTextField.layer.cornerRadius = 7
    }
    
}
