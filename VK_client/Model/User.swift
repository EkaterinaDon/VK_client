//
//  Friends.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

// MARK: - FriendResponse
class FriendResponse: Decodable {
    let response: Response
}

// MARK: - Response
class Response: Decodable {
    let count: Int
    let items: [Friend]
}

// MARK: - Friend
class Friend: Decodable {
    
    static let instance = Friend()
    
    var id: Int = 0
    var firstName: String = ""
     var lastName: String = ""
     var photo: String = ""

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case photo
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try value.decode(Int.self, forKey: .id)
        self.firstName = try value.decode(String.self, forKey: .firstName)
        self.lastName = try value.decode(String.self, forKey: .lastName)
        self.photo = try value.decode(String.self, forKey: .photo)
    }
}
