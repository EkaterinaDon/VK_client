//
//  NewsServiceAPI.swift
//  VK_client
//
//  Created by Ekaterina on 3.11.20.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import Alamofire


class NewsService {
    
    let baseUrl = "https://api.vk.com"
    
    func getNews(user_id: String, completion: @escaping ([News], [NewsFromGroup], [Profile]) -> Void ) {
        let path = "/method/newsfeed.get"
        let parameters: Parameters = [
            Session.instance.userId: user_id,
            "filters": "post",
            "method": "newsfeed.get",
            "access_token": Session.instance.token,
            "v": "5.124"
        ]
        
        let url = baseUrl+path
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            
            DispatchQueue.global(qos: .userInteractive).async {
                let news = try! JSONDecoder().decode(NewsResult.self, from: data).response?.items
                guard let empty = news?.isEmpty, !empty else { return }
                
                let groupNews = try! JSONDecoder().decode(NewsResult.self, from: data).response?.groups
                guard let emptyGroup = groupNews?.isEmpty, !emptyGroup else { return }
                
                let profileNews = try! JSONDecoder().decode(NewsResult.self, from: data).response?.profiles
                guard let emptyProfile = groupNews?.isEmpty, !emptyProfile else { return }
                
                DispatchQueue.main.async {
                    completion(news!, groupNews!, profileNews!)
                }
            }
        }
        
    }
    
}

