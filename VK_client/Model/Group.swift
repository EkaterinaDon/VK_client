//
//  Group.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - GroupResponse
class GroupResponse: Decodable {
    let response: ResponseGroup
}

// MARK: - ResponseGroup
class ResponseGroup: Decodable {
    let count: Int
    let items: [Group]
}

// MARK: - Group
class Group: Object, Decodable {
    
    static let instance = Group()
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case photo = "photo_50"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try value.decode(Int.self, forKey: .id)
        self.name = try value.decode(String.self, forKey: .name)
        self.photo = try value.decode(String.self, forKey: .photo)
    }
    override class func primaryKey() -> String {
            return "id"
        }

}

