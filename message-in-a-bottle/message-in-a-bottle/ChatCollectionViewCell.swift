//
//  ChatCollectionViewCell.swift
//  message-in-a-bottle
//
//  Created by Felicity Johnson on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ChatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var chatTitleLabel: UILabel!
    let chatParticipantLabel = UILabel()
    let chatWithLabel = UILabel()
    
    func setUpViews() {
        chatTitleLabel.text = ""
        
        self.contentView.addSubview(chatWithLabel)
        chatWithLabel.text = "Chat with"
        chatWithLabel.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height * 0.25)
        chatWithLabel.backgroundColor = UIColor.red
        chatWithLabel.textAlignment = .center
        chatWithLabel.font = UIFont(name: "HelveticaNeue-Light", size: 13)
        
        
        self.contentView.addSubview(chatParticipantLabel)
        chatParticipantLabel.frame = CGRect(x: 0, y: contentView.frame.height * 0.25, width: self.contentView.frame.width, height: self.contentView.frame.height * 0.6)
        chatParticipantLabel.numberOfLines = 2
        chatParticipantLabel.textAlignment = .center
        chatParticipantLabel.font = UIFont(name: "HelveticaNeue", size: 20)
    }
}
