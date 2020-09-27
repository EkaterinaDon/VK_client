//
//  GroupServiceAPI.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 27/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation

class GroupService {
    
    var session = Session.instance
    
    func getGroups() {
        
        let configuration = URLSessionConfiguration.default
        let mySession = URLSession(configuration: configuration)
        
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.vk.com"
                urlComponents.path = "/method/groups.get"
                urlComponents.queryItems = [
                    URLQueryItem(name: "user_id", value: "535747820"),
                    URLQueryItem(name: "count", value: "3"),
                    URLQueryItem(name: "method", value: "groups.get"),
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
