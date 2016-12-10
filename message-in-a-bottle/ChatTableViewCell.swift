//
//  ChatTableViewCell.swift
//  message-in-a-bottle
//
//  Created by Felicity Johnson on 11/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    var displayNameLabel = UILabel()
    var messageContentLabel = UILabel()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "chatMessageCell")
        
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configureCell() {
        
        addSubview(displayNameLabel)
        displayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        displayNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        displayNameLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        
        addSubview(messageContentLabel)
        messageContentLabel.translatesAutoresizingMaskIntoConstraints = false
        messageContentLabel.leftAnchor.constraint(equalTo: displayNameLabel.rightAnchor, constant: 5).isActive = true
    }

}
