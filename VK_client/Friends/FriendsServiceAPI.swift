//
//  FriendsServiceAPI.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 27/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation


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
    
    func getPhotos() {
        
        let configuration = URLSessionConfiguration.default
        let mySession = URLSession(configuration: configuration)
        
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.vk.com"
                urlComponents.path = "/method/photos.get"
                urlComponents.queryItems = [
                    URLQueryItem(name: "owner_id", value: "7609951"),
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
    
    
}
