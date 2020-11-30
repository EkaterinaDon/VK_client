//
//  FriendsCollectionViewController.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit


class FriendsCollectionViewController: UICollectionViewController {
    
    var friendsPhotos = [Item]()
    var friend: FriendFireStore!
    var friendsService = FriendsService()
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendsService.getPhoto(owner_id: "\(friend.id)") { [weak self] friendsPhotos in
            self?.friendsPhotos = friendsPhotos
            self?.imagesFromUrls()
        }
        
        title = friend.name
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard !images.isEmpty else { return 0 }
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotoCell", for: indexPath) as! FriendsCollectionViewCell
        guard !images.isEmpty else { return cell }
        let friendsPhotos = images[indexPath.row]
        cell.friendsPhoto.image = friendsPhotos
        
        return cell
    }
    
    func imagesFromUrls() {
        
        let photoUrls = friendsPhotos.compactMap{ $0.sizes }.flatMap { $0 }.filter {$0.type == "m"}.compactMap { $0.url }
        for urls in photoUrls {
            guard let url = URL(string: urls) else { return }
                UIImage.loadPhotos(url: url) { [weak self] image in
                    self?.images.append(image!)
                    self!.collectionView.reloadData()
                }
        }

    }
}
