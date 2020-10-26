//
//  UserFirebase.swift
//  VK_client
//
//  Created by Ekaterina on 21.10.20.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import Firebase

class FriendFirebase {

    var id: Double
    var first_name: String
    var last_name: String
    var photo: String
    let ref: DatabaseReference?
    
    init(id: Double, first_name: String, last_name: String, photo: String) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.photo = photo
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any], let id = value["id"] as? Double, let first_name = value["first_name"] as? String, let last_name = value["last_name"] as? String, let photo = value["photo"] as? String else {
            return nil
        }
        self.ref = snapshot.ref
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.photo = photo
    }
    func toAnyObject() -> [String: Any] {
            // 4
            return [
                "id": id,
                "first_name": first_name,
                "last_name": last_name,
                "photo": photo
            ]
        }

    
}
