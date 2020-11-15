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
import FirebaseDatabase
import FirebaseFirestore
import FirebaseFirestoreSwift
import PromiseKit

class FriendsService {
    
    let baseUrl = "https://api.vk.com"

    func getFriend() -> Promise<[Friend]> {

        let path = "/method/friends.get"
        let parameters: Parameters = [
            "user_id": Session.instance.userId,
            "order": "hints",
            "fields": "photo",
            "method": "friends.get",
            "access_token": Session.instance.token,
            "v": "5.124"
        ]

        let url = baseUrl+path
        return Promise<[Friend]> { resolver in
            AF.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
                switch response.result {
                case let .success(data):
                    let friend = try! JSONDecoder().decode(FriendResponse.self, from: data).response.items
                    resolver.fulfill(friend)
                    self?.saveFriends(friend)
                    self?.saveFriendsToFirestore(friend)
                case let .failure(error):
                    resolver.reject(error)
                }

            }
        }
       
    }
    
    
    func saveFriends(_ friends: [Friend]) {
        
        do {
            
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            
            let oldFriends = realm.objects(Friend.self)
            realm.beginWrite()
            realm.delete(oldFriends)
            realm.add(friends)
            debugPrint(realm.configuration.fileURL!)
            try realm.commitWrite()
        } catch {
            debugPrint(error)
        }
    }

    func saveFriendsToFirestore(_ friends: [Friend]) {
        let database = Firestore.firestore()
        
        for friend in friends {
            
            database.collection("friends").document("\(friend.id)").setData(friend.toFirestore(), merge: true) {
                error in
                if let error = error {
                    debugPrint(error.localizedDescription)
                } else {
                  //  debugPrint("data saved \(friend.first_name)")
                }
            }
        }
    }
    
        func getPhoto(owner_id: String, completion: @escaping ([Item]) -> Void ) {
            let path = "/method/photos.get"
            let parameters: Parameters = [
                "owner_id": owner_id,
                "album_id": "profile",
                "count": "3",
                "method": "photos.get",
                "access_token": Session.instance.token,
                "v": "5.124"
            ]
            
            let url = baseUrl+path
            AF.request(url, method: .get, parameters: parameters).responseData { response in
                guard let data = response.value else { return }
                let photos = try! JSONDecoder().decode(RootClass.self, from: data).response.items
                completion(photos)
            
        }
    }
}

