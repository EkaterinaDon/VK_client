//
//  News.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 30/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class NewsResult: Decodable {
    
    let response: NewsResponse?
}

class NewsResponse: Decodable {
    
    var groups: [NewsFromGroup] // Group
    var items: [News] // Items
    var profiles: [Profile]

}

class Profile: Decodable {
    
    var firstName: String?
    var id: Double = 0
    var lastName: String?
    var photo50: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id = "id"
        case lastName = "last_name"
        case photo50 = "photo_50"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        self.id = try values.decode(Double.self, forKey: .id)
        self.lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        self.photo50 = try values.decodeIfPresent(String.self, forKey: .photo50)
    }
    
    var name: String { return firstName! + " " + lastName! }
}

class NewsFromGroup: Decodable {
    
    var id: Double = 0
    var name: String?
    var photo50: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photo50 = "photo_50"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Double.self, forKey: .id)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.photo50 = try values.decodeIfPresent(String.self, forKey: .photo50)
    }
}

class News: Decodable {
    
    static let instance = News()
    
    var attachments: [Attachment]?
    var comments: Comment?
    var date: Double?
    var sourceId: Double = 0
    var likes: Like?
    var text: String?
    var views: View?
    var newsName: String?
    var newsPhoto: String = ""
    
    enum CodingKeys: String, CodingKey {
        case attachments = "attachments"
        case comments = "comments"
        case date = "date"
        case sourceId = "source_id"
        case likes = "likes"
        case text = "text"
        case views = "views"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.attachments = try values.decodeIfPresent([Attachment].self, forKey: .attachments)
        self.comments = try Comment(from: decoder)
        self.date = try values.decodeIfPresent(Double.self, forKey: .date)
        self.sourceId = try values.decode(Double.self, forKey: .sourceId)
        self.likes = try Like(from: decoder)
        self.text = try values.decodeIfPresent(String.self, forKey: .text)
        self.views = try View(from: decoder)
    }
    

}

class View: Decodable {
    
    var count: Int?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try values.decodeIfPresent(Int.self, forKey: .count)
    }
}

class Like: Decodable {
    
    var count: Int?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try values.decodeIfPresent(Int.self, forKey: .count)
    }
}

class Comment: Decodable {
    
    var count: Int?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try values.decodeIfPresent(Int.self, forKey: .count)
    }
}

class Attachment: Decodable {
    
    var photo: NewsPhoto?
}

class NewsPhoto: Decodable {
    
    var sizes: [PhotoForNews]?
    
}

class PhotoForNews: Decodable {
    
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}
