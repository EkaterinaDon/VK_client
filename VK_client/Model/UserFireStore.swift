//
//  UserFireStore.swift
//  VK_client
//
//  Created by Ekaterina on 22.10.20.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit
import FirebaseFirestore
//import RealmSwift

class FriendFireStore: Codable {
    var id: Double = 0
    var first_name: String = ""
    var last_name: String = ""
    var photo: String = ""
    
    enum FireStoreCodingKeys: String, CodingKey {
        case id
        case first_name
        case last_name
        case photo
    }
    
    convenience init(dictionary: [String: Any]) {
        let id = (dictionary["id"] as! Double)
        let first_name = dictionary["first_name"] as! String
        let last_name = dictionary["last_name"] as! String
        let photo = dictionary["photo"] as! String
        self.init()
    }
}
