//
//  BottlesViewController.swift
//  message-in-a-bottle
//
//  Created by Dave Neff on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase



class BottlesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var bottles = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveBottleMessages()
    }
    
    func retrieveBottleMessages() {
        
        print("PROGRESS: Retreiving Bottle Messages...")
        guard let uniqueID = FIRAuth.auth()?.currentUser?.uid else { return }
        
        FirebaseMethods.retrieveBottlesForUser(uniqueID: uniqueID) { (messages) in
            print("PROGRESS: Ran the Retrieve Bottle Messages Firebase method...")
            
            print("PROGRESS: Retreived \(messages.count) messages...")
            self.bottles = messages
            self.collectionView!.reloadData()
            print("SUCCESS: Done!")
        }
    }
    
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return bottles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottleCell", for: indexPath) as! BottleCollectionViewCell
    
        cell.backgroundColor = UIColor.red
        
        dump(bottles[indexPath.row])
        
//
//        cell.bgImageView.image = UIImage(named: "")
//        cell.fgImageView.image = UIImage(named: "")
//        cell.bottleImageView.image = UIImage(named: "")
        
        return cell
    }

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

}
