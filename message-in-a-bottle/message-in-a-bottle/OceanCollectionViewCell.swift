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
    var oceanImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        print("OceansCollectionViewCell frame init called")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        print("ERROR: OceansCollectionViewCell aDecoder init called")
    }
    
    func setupView() {
        // Background color
        self.backgroundColor = UIColor.darkGray
        
        // Style constants
        let labelFont = UIFont(name: "Helvetica Neue UltraLight", size: 24)
        let labelColor = UIColor.black
        
        // Image
        self.contentView.addSubview(oceanImage)
        oceanImage.image = #imageLiteral(resourceName: "dave")
        
        oceanImage.translatesAutoresizingMaskIntoConstraints = false
        oceanImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75).isActive = true
        oceanImage.widthAnchor.constraint(equalTo: oceanImage.heightAnchor, multiplier: 1).isActive = true
        oceanImage.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        oceanImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        // Labels
        self.contentView.addSubview(oceanLabel)
        oceanLabel.font = labelFont
        oceanLabel.text = "Ocean"
        oceanLabel.textColor = labelColor
        oceanLabel.textAlignment = .center
        
        oceanLabel.translatesAutoresizingMaskIntoConstraints = false
        oceanLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        oceanLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        oceanLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        oceanLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.10).isActive = true
        
    }
    
}
