//
//  ChatroomViewController.swift
//  message-in-a-bottle
//
//  Created by Felicity Johnson on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase

class ChatroomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    let textField = UITextField()
    let sendButton = UIButton()
    
    var chatID = String()
    var chatMessagesArray = [ChatMessage]()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "chatMessageCell")
        
        //TableView
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.95).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        
        //Textfield
        
        self.view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.black.cgColor
        
        //Send message button
        
        self.view.addSubview(sendButton)
        sendButton.layer.borderWidth = 2.0
        sendButton.layer.borderColor = UIColor.black.cgColor
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(UIColor.blue, for: .normal)
        sendButton.addTarget(self, action: #selector(sendChat), for: .touchUpInside)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        sendButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        FirebaseMethods.retrieveChatMessages(chatID: chatID) { (chatMessages) in
            for chat in chatMessages {
                self.chatMessagesArray.append(chat)
            }
            self.tableView.reloadData()
        }
        

    }
    
    
    func sendChat(sender: UIButton!) {
        
        guard let userKey = FIRAuth.auth()?.currentUser?.uid else {return}
        FirebaseMethods.sendMessage(senderID: userKey, messageContent: textField.text!, chatID: chatID)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatMessageCell", for: indexPath)
        
        cell.textLabel?.text = chatMessagesArray[indexPath.row].content

        return cell
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
