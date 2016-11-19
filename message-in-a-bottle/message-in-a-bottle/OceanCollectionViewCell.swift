//
//  OceanCollectionViewCell.swift
//  message-in-a-bottle
//
//  Created by Benjamin Su on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class OceanCollectionViewCell: UICollectionViewCell {
    
    var oceanLabel = UILabel()
    var oceanIcon = UILabel()
    
    
    func setupView(oceanName: String) {
        // Background color
        self.backgroundColor = UIColor.lightGray
        
        // Style constants
        let labelFont = UIFont(name: "Helvetica", size: 24)
        let labelColor = UIColor.black
        
        // Image
        self.contentView.addSubview(oceanIcon)
        
        oceanIcon.translatesAutoresizingMaskIntoConstraints = false
        oceanIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75).isActive = true
        oceanIcon.widthAnchor.constraint(equalTo: oceanIcon.heightAnchor, multiplier: 1).isActive = true
        oceanIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        oceanIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        let iconFont = UIFont(name: IconFont.name, size: IconFont.sizeM)
        let iconColor = UIColor.black
        oceanIcon.font = iconFont
        oceanIcon.text = Icons.returnIcon(for: oceanName)
        oceanIcon.textColor = iconColor
        oceanIcon.textAlignment = .center
        
        // Labels
        self.contentView.addSubview(oceanLabel)
        oceanLabel.font = labelFont
        oceanLabel.text = oceanName
        oceanLabel.textColor = labelColor
        oceanLabel.textAlignment = .center
        
        oceanLabel.translatesAutoresizingMaskIntoConstraints = false
        oceanLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        oceanLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        oceanLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        oceanLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        
    }
    
}
