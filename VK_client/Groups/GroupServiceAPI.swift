//
//  GroupServiceAPI.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 27/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class GroupService {
    
    let baseUrl = "https://api.vk.com"

    //func getGroup(user_id: String, completion: @escaping ([Group]) -> Void )
    func getGroup(user_id: String) {
            let path = "/method/groups.get"
            let parameters: Parameters = [
                Session.instance.userId: user_id,
                "extended": "1",
                "fields": ["name", "photo_50"],
                "method": "groups.get",
                "access_token": Session.instance.token,
                "v": "5.124"
            ]
            
            let url = baseUrl+path
       
                AF.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
                    guard let data = response.value else { return }
                    let group = try! JSONDecoder().decode(GroupResponse.self, from: data).response.items
                    self?.saveGroups(group)
                    //debugPrint(group)
                   // completion(group)
                }
                    
            }


    func saveGroups(_ groups: [Group]) {

        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)

            let oldGroups = realm.objects(Group.self)
            realm.beginWrite()
            realm.delete(oldGroups)
            realm.add(groups)
            //debugPrint(realm.configuration.fileURL!)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

}
