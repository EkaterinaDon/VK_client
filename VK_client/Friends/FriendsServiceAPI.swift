//
//  FriendsServiceAPI.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 27/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class FriendsService {
    
    var session = Session.instance
    let baseUrl = "https://api.vk.com"
    
    func getFriend(user_id: String, completion: @escaping ([Friend]) -> Void ) {
        let access_token = session.token
        let path = "/method/friends.get"
        let parameters: Parameters = [
            "6492": user_id,
            "order": "hints",
            "fields": "photo",
            "method": "friends.get",
            "access_token": access_token,
            "v": "5.124"
        ]
        
        let url = baseUrl+path
        
        AF.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
            guard let data = response.value else { return }
            let friend = try! JSONDecoder().decode(FriendResponse.self, from: data).response.items

            self?.saveFriends(friend)

            completion(friend)
        }
      
    }
    
   
        func saveFriends(_ friends: [Friend]) {
   
            do {
    
                let realm = try Realm()

                realm.beginWrite()

                realm.add(friends)

                try realm.commitWrite()
            } catch {
                print(error)
            }
        }

    
    func getPhoto(owner_id: String, completion: @escaping ([Photos]) -> Void ) {
        let access_token = session.token
        let path = "/method/photos.get"
        let parameters: Parameters = [
            "3441530": owner_id,
            "album_id": "profile",
            "count": "3",
            "method": "photos.get",
            "access_token": access_token,
            "v": "5.124"
        ]
        
        let url = baseUrl+path

        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            let photos = try! JSONDecoder().decode(PhotosResponse.self, from: data).response.items
            
                  completion(photos)

        }
        
    }
    
}

