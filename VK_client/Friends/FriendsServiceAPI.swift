//
//  FriendsServiceAPI.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 27/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import Alamofire

class FriendsService {
    
    var session = Session.instance
    
    func getFriends() {
        
        let configuration = URLSessionConfiguration.default
        let mySession = URLSession(configuration: configuration)
        
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.vk.com"
                urlComponents.path = "/method/friends.get"
                urlComponents.queryItems = [
                    URLQueryItem(name: "user_id", value: "7609950"),
                    URLQueryItem(name: "order", value: "hints"),
                    URLQueryItem(name: "fields", value: "photo"),
                    URLQueryItem(name: "method", value: "friends.get"),
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
                // запрос
                        AF.request(url, method: .get, parameters: parameters).responseData { response in
                            guard let data = response.value else { return }
                      let friend = try! JSONDecoder().decode(FriendResponse.self, from: data).items
                
                            completion(friend)
                        }
                            
                    }

           
    
    
    func getPhotos() {
        
        let configuration = URLSessionConfiguration.default
        let mySession = URLSession(configuration: configuration)
        
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.vk.com"
                urlComponents.path = "/method/photos.get"
                urlComponents.queryItems = [
                    URLQueryItem(name: "owner_id", value: "3441530"),
                    URLQueryItem(name: "album_id", value: "profile"),
                    URLQueryItem(name: "count", value: "3"),
                    URLQueryItem(name: "method", value: "photos.get"),
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
    
    func getPhoto(owner_id: String, completion: @escaping ([Friend]) -> Void ) {
        let access_token = session.token
            let path = "/method/photos.get"
            let parameters: Parameters = [
                "7609950": owner_id,
                "album_id": "profile",
                "count": "3",
                "method": "photos.get",
                "access_token": access_token,
                "v": "5.124"
            ]
            
            let url = baseUrl+path
        // запрос
                AF.request(url, method: .get, parameters: parameters).responseData { response in
                    guard let data = response.value else { return }
              let friend = try! JSONDecoder().decode(FriendResponse.self, from: data).items
        
                    completion(friend)
                }
                    
            }
    
}

