//
//  SearchGroupServiceAPI.swift
//  VK_client
//
//  Created by Ekaterina on 27.10.20.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class SearchGroupService {
    
    let baseUrl = "https://api.vk.com"

    func searchGroup(user_id: String, searchText: String, completion: @escaping ([SearchResult]) -> Void ) {
            let path = "/method/groups.search"
            let parameters: Parameters = [
                Session.instance.userId: user_id,
                "q": searchText,
                "sort": "0",
                "method": "groups.search",
                "access_token": Session.instance.token,
                "v": "5.124"
            ]
            
            let url = baseUrl+path
       
                AF.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
                    guard let data = response.value else { return }
                    let groupSearch = try! JSONDecoder().decode(SearchResponse.self, from: data).response?.items
                    guard let empty = groupSearch?.isEmpty, !empty else { return }
                    self?.saveSearchGroupsResult(groupSearch!)
                    completion(groupSearch!)
                }
                    
            }

    
    func saveSearchGroupsResult(_ groupSearch: [SearchResult]) {

        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)

            let oldSearchResults = realm.objects(SearchResult.self)
            realm.beginWrite()
            realm.delete(oldSearchResults)
            realm.add(groupSearch)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
