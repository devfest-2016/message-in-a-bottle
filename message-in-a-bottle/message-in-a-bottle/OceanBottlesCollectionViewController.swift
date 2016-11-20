//
//  OceanBottlesCollectionViewController.swift
//  
//
//  Created by Benjamin Su on 11/19/16.
//
//

import UIKit



class OceanBottlesCollectionViewController: UICollectionViewController {

    var ocean: Ocean!
    var bottles = [Message]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FirebaseMethods.retrieveMessages(for: ocean) { (messages) in
            self.bottles = messages
            self.collectionView?.reloadData()
        }
    }

 
    // MARK: UICollectionViewDataSource

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
    
        cell.backgroundColor = UIColor.cyan
        cell.loadViews()
        cell.bgImageView.image = UIImage(named: "bgwave")
        cell.fgImageView.image = UIImage(named: "fgwave")
        cell.bottleImageView.image = UIImage(named: "bottle")
        
        return cell
    }



}
