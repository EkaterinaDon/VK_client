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
    var isLoading: Bool = false

    func getNews(startFrom: String? = nil, startTime: Double? = nil, completion: @escaping ([News], [PhotoForNews], String?) -> Void ) {
        let path = "/method/newsfeed.get"
        var parameters: Parameters = [:]
        if let startFrom = startFrom {
            parameters = [
                "filters": "post",
                "start_from": startFrom,
                "method": "newsfeed.get",
                "access_token": Session.instance.token,
                "v": "5.126"
            ]
        } else if let startTime = startTime {
            parameters = [
                "filters": "post",
                "start_time": startTime,
                "method": "newsfeed.get",
                "access_token": Session.instance.token,
                "v": "5.126"
            ]
        } else {
            parameters = [
                "filters": "post",
                "method": "newsfeed.get",
                "access_token": Session.instance.token,
                "v": "5.126"
            ]
        }
        
        let url = baseUrl+path
        if !isLoading {
            isLoading = true
        }
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            
            DispatchQueue.global(qos: .userInteractive).async { [self] in
                let news = try! JSONDecoder().decode(NewsResult.self, from: data).response?.items
                guard let empty = news?.isEmpty, !empty else { return }
                
                let groupNews = try! JSONDecoder().decode(NewsResult.self, from: data).response?.groups
                guard let emptyGroup = groupNews?.isEmpty, !emptyGroup else { return }
                
                let profileNews = try! JSONDecoder().decode(NewsResult.self, from: data).response?.profiles
                guard let emptyProfile = profileNews?.isEmpty, !emptyProfile else { return }
                
                let nextFrom = try! JSONDecoder().decode(NewsResult.self, from: data).response?.nextFrom
                
                let photoForNews = try! JSONDecoder().decode(NewsResult.self, from: data).response?.items!.compactMap { $0.attachments }.reduce([], +).compactMap { $0.photo }.compactMap { $0.sizes }.reduce([], +)
                guard let emptyPhotos = photoForNews?.isEmpty, !emptyPhotos else { return }
                
                let attachment = try! JSONDecoder().decode(NewsResult.self, from: data).response?.items!.compactMap { $0.attachments }.reduce([], +)
                
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
                    newsItem.attachments = attachment
                    //newsItem.newsPhotos = photoForNews
                }
                DispatchQueue.main.async {
                    completion(news!, photoForNews!, nextFrom)
                }
                if isLoading {
                    self.isLoading = false
                }
            }
        }
        
    }
    
}

