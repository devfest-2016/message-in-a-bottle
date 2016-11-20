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
    var recipientName = String()
    
    var chatRef = FIRDatabase.database().reference()
    
    var timer = Timer()
    
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
        
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(readFireBaseData), userInfo: nil, repeats: true)
    }
    
    func readFireBaseData() {
        FirebaseMethods.retrieveChatMessages(chatID: chatID) { (chatMessages) in
            for chat in chatMessages {
                self.chatMessagesArray.append(chat)
//            self.tableView.insertRows(at: [IndexPath(row: self.chatMessagesArray.count-1, section: 0)], with: .automatic)
            }
            self.tableView.reloadData()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        var chatMessages = [ChatMessage]()
        
        print("Chat Ref: \(chatRef)")
        
        chatRef.observe(.childAdded, with: { (snapshot) in
            guard let chatInfoRaw = snapshot.value as? [String:Any] else {return}
            let messageID = snapshot.key
            
            guard let senderName = chatInfoRaw["senderName"] as? String,
                let senderUniqueKey = chatInfoRaw["senderUniqueKey"] as? String,
                let content = chatInfoRaw["messageContent"] as? String,
                let timestampString = chatInfoRaw["timestamp"] as? String,
                let timestamp = Double(timestampString)
                else {return}

            let chatMessageToAppend = ChatMessage(senderName: senderName, messageID: messageID, senderUniqueKey: senderUniqueKey, content: content, timestamp: timestamp)
                self.chatMessagesArray.append(chatMessageToAppend)
                self.tableView.reloadData()
                
            })
        }

    
    func sendChat(sender: UIButton!) {
        
        guard let userKey = FIRAuth.auth()?.currentUser?.uid else {return}
        FirebaseMethods.sendMessage(senderID: userKey, messageContent: textField.text!, chatID: chatID)
        textField.text = ""
        
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
        
        let nameToShow = chatMessagesArray[indexPath.row].senderName
        let contentToShow = chatMessagesArray[indexPath.row].content
        let cellToShow = "\(nameToShow): \(contentToShow)"
        
        cell.textLabel?.text = cellToShow

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
