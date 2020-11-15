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
    var friend: FriendFireStore!
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        friendsService.getPhoto(owner_id: "\(friend.id)") { [weak self] friendsPhotos in
            self?.friendsPhotos = friendsPhotos
            
            self?.collectionView.reloadData()
        }
        
        title = friend.name
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3//friend.photo.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotoCell", for: indexPath) as! FriendsCollectionViewCell
        
       
        //let photo1 = friend.photo[indexPath.row]
        //cell.friendsPhoto.image = photo1
        
        
        return cell
    }
    
    func array() -> [String?] {
       
        var array: [[Size]] = []
        for data in friendsPhotos {
            array.append(data.sizes!)
        }
        var sizeArray: [Size] = []
        for sizes in array {
            sizeArray.append(contentsOf: sizes)
        }
        
        let urlArray = sizeArray.map { $0.url }

        for urls in urlArray {
            let url = URL(string: urls!)

            UIImage.loadFriendsImage(url: url!) { [weak self] image in
               // self.firstImage.image = image
                self?.images.append(image!)
            }
        }
      //  firstImage.image = images[0]
        return urlArray
    }
}
