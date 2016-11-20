//
//  OceanBottlesCollectionViewController.swift
//  
//
//  Created by Benjamin Su on 11/19/16.
//
//

import UIKit



class OceanBottlesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? OceanBottleViewMsgsViewController,
            let index = collectionView?.indexPathsForSelectedItems?[0] {
            dest.message = bottles[index.row]
        }
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
