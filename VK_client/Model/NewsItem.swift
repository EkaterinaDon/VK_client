//
//  NewsItem.swift
//  VK_client
//
//  Created by Ekaterina on 4.11.20.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation


enum NewsModelType {
    case fromFriend
    case fromGroup
}

protocol NewsViewModel {
    var type: NewsModelType { get }
    var rowCount: Int { get }
}

extension NewsViewModel {
    var rowCount: Int {
        return 1
    }
}

class NewsFromFriends: NewsViewModel {
    var type: NewsModelType {
        return .fromFriend
    }
    
    
    
    
//    var friendFirstName: String
//    var friendLastName: String
//    var friendPictureUrl: String
//
//    init(friendFirstName: String, friendLastName: String, friendPictureUrl: String) {
//        self.friendFirstName = friendFirstName
//        self.friendLastName = friendLastName
//        self.friendPictureUrl = friendPictureUrl
//    }
    
}

