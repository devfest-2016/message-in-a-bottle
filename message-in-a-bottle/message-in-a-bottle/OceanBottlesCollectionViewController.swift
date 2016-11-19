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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

 
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottleCell", for: indexPath) as! BottleCollectionViewCell
    
        cell.loadViews()
        
        cell.bottleLabel.text = "ello World"
        
        return cell
    }



}
