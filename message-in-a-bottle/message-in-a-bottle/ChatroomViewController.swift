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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView
                self.view.addSubview(tableView)
                tableView.translatesAutoresizingMaskIntoConstraints = false
                tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50).isActive = true
                tableView.widthAnchor.constraint(equalToConstant: view.widthAnchor).isActive = true
                tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        
        //        //Textfield
                self.view.addSubview(textField)
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50).isActive = true
                textField.widthAnchor.constraint(equalToConstant: view.widthAnchor).isActive = true
                textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                textField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //        //Send message button
                self.view.addSubview(tableView)
                tableView.translatesAutoresizingMaskIntoConstraints = false
                tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50).isActive = true
                tableView.widthAnchor.constraint(equalToConstant: view.widthAnchor).isActive = true
                tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
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
