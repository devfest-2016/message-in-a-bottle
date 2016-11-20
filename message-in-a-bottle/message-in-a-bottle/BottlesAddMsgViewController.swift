//
//  BottlesAddMsgViewController.swift
//  message-in-a-bottle
//
//  Created by Dave Neff on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class BottlesAddMsgViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextView!
    
    var oceanName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(oceanName)
        // Do any additional setup after loading the view.
    }



    @IBAction func sendButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
    }
    
    
}
