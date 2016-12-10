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
    var iconCircle = UILabel()
    
    func setupView(oceanName: String) {
        // Text label
        let labelFont = UIFont(name: "Helvetica", size: 24)
        let labelColor = UIColor.white
        
        self.contentView.addSubview(oceanLabel)
        oceanLabel.font = labelFont
        oceanLabel.text = oceanName
        oceanLabel.textColor = labelColor
        oceanLabel.textAlignment = .center
        
        oceanLabel.translatesAutoresizingMaskIntoConstraints = false
        oceanLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        oceanLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        oceanLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        oceanLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
 
        // Icon
        let iconFont = UIFont(name: IconFont.name, size: IconFont.sizeXL)
        let iconColor = labelColor

        self.contentView.addSubview(oceanIcon)
        oceanIcon.text = Icons.returnIcon(for: oceanName)
        oceanIcon.font = iconFont
        oceanIcon.textColor = iconColor
        oceanIcon.textAlignment = .center
        oceanIcon.adjustsFontSizeToFitWidth = true

        oceanIcon.translatesAutoresizingMaskIntoConstraints = false
        oceanIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        oceanIcon.widthAnchor.constraint(equalTo: oceanIcon.heightAnchor, multiplier: 1).isActive = true
        oceanIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        oceanIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        // Circle around icon
        self.contentView.addSubview(iconCircle)
        iconCircle.text = Icons.circle
        iconCircle.font = UIFont(name: IconFont.name, size: 180)
        iconCircle.numberOfLines = 1
        iconCircle.adjustsFontSizeToFitWidth = true
        iconCircle.textColor = iconColor
        iconCircle.textAlignment = .center
        
        iconCircle.translatesAutoresizingMaskIntoConstraints = false
        iconCircle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        iconCircle.widthAnchor.constraint(equalTo: iconCircle.heightAnchor, multiplier: 1).isActive = true
        iconCircle.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        iconCircle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true

        
    
    }
    
}
