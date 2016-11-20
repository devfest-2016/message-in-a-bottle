//
//  BottlesViewOceansViewController.swift
//  message-in-a-bottle
//
//  Created by Dave Neff on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import FirebaseAuth


class BottlesViewOceansViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let backgroundImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        FirebaseMethods.createNewBottle(uniqueID: (FIRAuth.auth()?.currentUser?.uid)!, oceanID: "Tech", title: "Hello World", messageContent: "Are we human? Or are we dancer.")
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Ocean.oceanNames.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "oceanCell", for: indexPath) as! OceanCollectionViewCell
    
        cell.setupView(oceanName: Ocean.oceanNames[indexPath.row])
    
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? BottlesAddMsgViewController,
            let index = collectionView?.indexPathsForSelectedItems?[0] {
            dest.oceanName = Ocean.oceanNames[index.row]
        }
    }
    
    // MARK: - Collection View cell spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 12.0) / 2, height: (UIScreen.main.bounds.height - 16.0) / 3)
    }
    
    
    // MARK: - Setup view background
    func setupView() {
        // Add background
        collectionView?.backgroundView = backgroundImage
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = self.view.frame
        
        // Add background blur
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = collectionView!.frame
        backgroundImage.addSubview(blurEffectView)
    }

}
