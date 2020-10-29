//
//  GroupSearch.swift
//  VK_client
//
//  Created by Ekaterina on 27.10.20.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import RealmSwift

class SearchResponse : Decodable {

        let response : ResponseSearch?
}

class ResponseSearch : Decodable {

        let count : Int?
        let items : [SearchResult]?
}

class SearchResult : Object, Decodable {

    @objc dynamic var id : Int = 0
    @objc dynamic var name : String = ""
    @objc dynamic var photo50 : String = ""

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case name = "name"
                case photo50 = "photo_50"
        }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decode(Int.self, forKey: .id)
                name = try values.decode(String.self, forKey: .name)
                photo50 = try values.decode(String.self, forKey: .photo50)
        }
    override class func primaryKey() -> String {
            return "id"
        }

}
