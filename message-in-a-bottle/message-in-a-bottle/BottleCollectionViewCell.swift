//
//  BottleCollectionViewCell.swift
//  message-in-a-bottle
//
//  Created by Benjamin Su on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class BottleCollectionViewCell: UICollectionViewCell {
 
    var bottleLabel: UILabel!
    var bottleImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadViews() {
        bottleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height * 0.25))
        bottleImage = UIImageView(frame: CGRect(x: 0.0, y: frame.size.height * 0.25, width: frame.size.width, height: frame.size.height * 0.75))
    }
    
    
    
}
