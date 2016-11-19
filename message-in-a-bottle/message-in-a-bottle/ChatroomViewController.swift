//
//  ChatroomViewController.swift
//  message-in-a-bottle
//
//  Created by Felicity Johnson on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ChatroomViewController: UIViewController {
    
    
    
    let tableView = UITableView()
    let textField = UITextField()
    let sendButton = UIButton()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
            //TableView
        
                self.view.addSubview(tableView)
                tableView.translatesAutoresizingMaskIntoConstraints = false
                tableView.bottomAnchor.constraint(equalTo: textField.topAnchor).isActive = true
                tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
                tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        
            //Textfield
        
                self.view.addSubview(textField)
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
                textField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
                textField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
                textField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
            //Send message button
        
                self.view.addSubview(sendButton)
                sendButton.layer.borderWidth = 2.0
                sendButton.layer.borderColor = UIColor.black.cgColor
                sendButton.titleLabel?.text = "Send"
                sendButton.translatesAutoresizingMaskIntoConstraints = false
                sendButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
                sendButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
                sendButton.leftAnchor.constraint(equalTo: textField.rightAnchor).isActive = true
                sendButton.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
