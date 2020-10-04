//
//  Friends.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit


class Friend: Decodable {

    static let instance = Friend()

    
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var photo: URL?
    
    enum CodingKeys: String, CodingKey {
        
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo"
    }

    enum FirstKey: String, CodingKey {
        case response = "response"
            }
    
    enum SecondKey: String, CodingKey {
        case count, items
    }
    
    convenience required init(from decoder: Decoder) throws {
            self.init()
        let value = try decoder.container(keyedBy: FirstKey.self)
        let firstValue = try value.nestedContainer(keyedBy: SecondKey.self, forKey: .response)
        let secondValue = try firstValue.nestedContainer(keyedBy: CodingKeys.self, forKey: .items)
        self.firstName = try secondValue.decode(String.self, forKey: .firstName)
        self.lastName = try secondValue.decode(String.self, forKey: .lastName)
        self.photo = try secondValue.decode(URL.self, forKey: .photo)
       
    }
}

class FriendResponse: Decodable {
    let items: [Friend]
}

