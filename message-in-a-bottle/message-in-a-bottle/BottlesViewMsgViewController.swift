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
    
    let backgroundImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: {
        })
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
