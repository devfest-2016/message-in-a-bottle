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
    var fgImageView: UIImageView!
    var bgImageView: UIImageView!
    var bottleImageView: UIImageView!
    
    
    func loadViews() {
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.themeDarkBlue.cgColor
        self.backgroundColor = UIColor.themeBrightBlue
        
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        
        bottleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height * 0.25))
        bottleLabel.textAlignment = .center
        self.contentView.addSubview(bottleLabel)
        bgImageView = UIImageView(frame: CGRect(x: frame.size.width * -0.1, y: frame.size.height * 0.3, width: frame.size.width * 1.2, height: frame.size.height * 0.8))
        bgImageView.image = UIImage(named: "wave")
        self.contentView.addSubview(bgImageView)
        bottleImageView = UIImageView(frame: CGRect(x: frame.size.width * 0.425, y: frame.size.height * 0.55, width: frame.size.width * 0.15, height: frame.size.width * 0.5))
        bottleImageView.image = UIImage(named: "bottle")
        self.contentView.addSubview(bottleImageView)
        fgImageView = UIImageView(frame: CGRect(x: frame.size.width * -0.15, y: frame.size.height * 0.6, width: frame.size.width * 1.3, height: frame.size.height * 0.5))
        fgImageView.image = UIImage(named: "wave")
        self.contentView.addSubview(fgImageView)
        
        animateForeground()
        animateBackground()
        animateBottle()
    }
    
    func animateBackground() {
        
        let duration = Double(arc4random_uniform(5)) + 10
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: [.repeat, .allowUserInteraction, .calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                self.bgImageView.transform = CGAffineTransform.init(scaleX: 0.9, y: 1.1)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.25, animations: {
                self.bgImageView.transform = CGAffineTransform.init(scaleX: 1, y: 0.9)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.45, relativeDuration: 0.3, animations: {
                self.bgImageView.transform = CGAffineTransform.init(scaleX: 0.9, y: 1.1)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                self.bgImageView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            })
        })
    }
    
    func animateForeground() {
        
        let duration = Double(arc4random_uniform(5)) + 8
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: [.repeat, .allowUserInteraction, . calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                self.fgImageView.center.x += 5
                self.fgImageView.center.y -= 10
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.25, animations: {
                self.fgImageView.center.x += 5
                self.fgImageView.center.y += 10
            })
            UIView.addKeyframe(withRelativeStartTime: 0.45, relativeDuration: 0.25, animations: {
                self.fgImageView.center.x -= 5
                self.fgImageView.center.y += 10
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                self.fgImageView.center.x -= 5
                self.fgImageView.center.y -= 10
            })
        })
    }
    
    func animateBottle() {
        
        let duration = Double(arc4random_uniform(6)) + 12
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: [.repeat, .allowUserInteraction, . calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                self.bottleImageView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1).rotated(by: 0.4)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.25, animations: {
                self.bottleImageView.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9).rotated(by: 0.1)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.45, relativeDuration: 0.25, animations: {
                self.bottleImageView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1).rotated(by: 0.2)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                self.bottleImageView.transform = CGAffineTransform.init(scaleX: 1, y: 1).rotated(by: 0)
            })
        })
    }
    
}
