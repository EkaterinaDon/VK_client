//
//  Group.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation

//struct Group {
//    let name: String
//    let imageName: String
//}

class Group: Decodable {

    static let instance = Group()

    
    dynamic var name: String = ""
    dynamic var photo: URL?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case photo = "photo_50"
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
        self.name = try secondValue.decode(String.self, forKey: .name)
        self.photo = try secondValue.decode(URL.self, forKey: .photo)
       
    }
}

class GroupResponse: Decodable {
    let items: [Group]
}


extension Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.photo == rhs.photo
           
    }
}
