//
//  FriendsCollectionViewController.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit


class FriendsCollectionViewController: UICollectionViewController {
    
    var friendsService = FriendsService()
    var friendsPhotos = [Item]()
    var friend: FriendFireStore! //Friend!
   // var images = [UIImage]()
    var photoCollection = FriendsPhotoCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = friend.name
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        let images = photoCollection.images
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotoCell", for: indexPath) as! FriendsCollectionViewCell
        let images = photoCollection.images
        let friendsPhotos = images[indexPath.row]
        cell.friendsPhoto.image = friendsPhotos
        
        return cell
    }
    
}
