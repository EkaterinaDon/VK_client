//
//  GroupServiceAPI.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 27/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import Alamofire

class GroupService {
    
    var session = Session.instance
    
    let baseUrl = "https://api.vk.com"

        func getGroup(user_id: String, completion: @escaping ([Group]) -> Void ) {
            let access_token = session.token
                let path = "/method/groups.get"
                let parameters: Parameters = [
                    "6492": user_id,
                    "extended": "1",
                    "fields": ["name", "photo_50"],
                    "method": "groups.get",
                    "access_token": access_token,
                    "v": "5.124"
                ]
                
                let url = baseUrl+path
           
                    AF.request(url, method: .get, parameters: parameters).responseData { response in
                        guard let data = response.value else { return }
                        let group = try! JSONDecoder().decode(GroupResponse.self, from: data).response.items
            
                        completion(group)
                    }
                        
                }
    
    
    
    func searchGroups() {
        
        let configuration = URLSessionConfiguration.default
        let mySession = URLSession(configuration: configuration)
        
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.vk.com"
                urlComponents.path = "/method/groups.search"
                urlComponents.queryItems = [
                    URLQueryItem(name: "q", value: "Bowie"),
                    URLQueryItem(name: "type", value: "group"),
                    URLQueryItem(name: "method", value: "groups.search"),
                    URLQueryItem(name: "count", value: "5"),
                    URLQueryItem(name: "access_token", value: session.token),
                    URLQueryItem(name: "v", value: "5.124")
                ]
        let task = mySession.dataTask(with: urlComponents.url!) {
            (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            debugPrint(json!)
        }
        task.resume()
    }
}
