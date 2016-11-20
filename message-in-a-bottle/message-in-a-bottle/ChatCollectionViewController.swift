//
//  ChatCollectionViewController.swift
//  message-in-a-bottle
//
//  Created by Felicity Johnson on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "chatCell"

class ChatCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var chatRoomArray = [Chatroom]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.collectionView!.register(UIColvartionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        FirebaseMethods.retrieveChatRooms(for: (FIRAuth.auth()?.currentUser!.uid)!) { (chatrooms) in
            print("CHATROOMS: \(chatrooms)")
            
            for chatroom in chatrooms {
                self.chatRoomArray.append(chatroom)
                print("CHATROOM ARRAY: \(self.chatRoomArray.count)")
            }
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
        return chatRoomArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCollectionViewCell
        
    
        
        cell.chatParticipantLabel.text = chatRoomArray[indexPath.item].partnerName
        cell.setUpViews()
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "individualChat" {
            let dest = segue.destination as! ChatroomViewController
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                for indexPath in indexPaths {
                    dest.chatID = chatRoomArray[indexPath.item].chatID
                    dest.chatRef = FIRDatabase.database().reference().child("chatMessages").child(dest.chatID)
                    dest.recipientName = chatRoomArray[indexPath.item].partnerName
                }
            }
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
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
