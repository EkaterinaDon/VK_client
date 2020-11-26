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
    
    func getNews(user_id: String, startFrom: String? = nil, startTime: Double? = nil, completion: @escaping ([News], String ) -> Void ) {
        let path = "/method/newsfeed.get"
        var parameters: Parameters = [:]
        if let startFrom = startFrom {
            parameters = [
                Session.instance.userId: user_id,
                "filters": "post",
                "start_from": startFrom,
                "method": "newsfeed.get",
                "access_token": Session.instance.token,
                "v": "5.68"
            ]
        } else if let startTime = startTime {
            parameters = [
                Session.instance.userId: user_id,
                "filters": "post",
                "start_time": startTime,
                "method": "newsfeed.get",
                "access_token": Session.instance.token,
                "v": "5.68"
            ]
        } else {
            parameters = [
                Session.instance.userId: user_id,
                "filters": "post",
                "method": "newsfeed.get",
                "access_token": Session.instance.token,
                "v": "5.68"
            ]
        }
        
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
                
                let nextFrom = try! JSONDecoder().decode(NewsResult.self, from: data).response?.nextFrom
                
                news?.forEach { newsItem in
                    if newsItem.sourceId > 0 {
                        let source = profileNews?.first(where: { $0.id == newsItem.sourceId})
                        newsItem.sourceId = source!.id
                        newsItem.newsPhoto = source!.photo50!
                        newsItem.newsName = source!.name
                    } else {
                        let source = groupNews?.first(where: { $0.id == -newsItem.sourceId})
                        newsItem.sourceId = source!.id
                        newsItem.newsPhoto = source!.photo50!
                        newsItem.newsName = source!.name
                    }
                }
                
                DispatchQueue.main.async {
                    completion(news!, nextFrom!)
                }
            }
        }
        
    }
    
}

