//
//  Friends.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit
import RealmSwift


// MARK: - FriendResponse
class FriendResponse: Decodable {
    let response: Response
}

// MARK: - Response
class Response: Object, Decodable {
    let count: Int
    let items: [Friend]
}

// MARK: - Friend
class Friend: Object, Decodable {

    static let instance = Friend()

    @objc dynamic var id: Double = 0
    @objc dynamic var first_name: String = ""
    @objc dynamic var last_name: String = ""
    @objc dynamic var photo: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case first_name
        case last_name
        case photo
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try value.decode(Double.self, forKey: .id)
        self.first_name = try value.decode(String.self, forKey: .first_name)
        self.last_name = try value.decode(String.self, forKey: .last_name)
        self.photo = try value.decode(String.self, forKey: .photo)
    }
    
    func friendPrimaryKey() -> String {
        return "id"
    }

}
