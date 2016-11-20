//
//  BottlesViewMsgViewController.swift
//  message-in-a-bottle
//
//  Created by Dave Neff on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class BottlesViewMsgViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



    
    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: {
        })
    }
    
    
    

}
