//
//  UserPhotos.swift
//  VK_client
//
//  Created by Ekaterina on 14.10.20.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation


struct RootClass : Codable {

        var response : ResponsePhotos

        enum CodingKeys: String, CodingKey {
                case response = "response"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
            response = try values.decode(ResponsePhotos.self, forKey: .response)
        }

}

struct ResponsePhotos : Codable {

   // var count : Int?
    var items : [Item]

        enum CodingKeys: String, CodingKey {
            //    case count = "count"
                case items = "items"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
              //  count = try values.decode(Int.self, forKey: .count)
                items = try values.decode([Item].self, forKey: .items)
        }

}

struct Item : Codable {

    var albumId : Int?
    var date : Int?
    var hasTags : Bool?
    var id : Int?
    var ownerId : Int?
    var postId : Int?
    var sizes : [Size]?
    var text : String?

        enum CodingKeys: String, CodingKey {
                case albumId = "album_id"
                case date = "date"
                case hasTags = "has_tags"
                case id = "id"
                case ownerId = "owner_id"
                case postId = "post_id"
                case sizes = "sizes"
                case text = "text"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                albumId = try values.decodeIfPresent(Int.self, forKey: .albumId)
                date = try values.decodeIfPresent(Int.self, forKey: .date)
                hasTags = try values.decodeIfPresent(Bool.self, forKey: .hasTags)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                ownerId = try values.decodeIfPresent(Int.self, forKey: .ownerId)
                postId = try values.decodeIfPresent(Int.self, forKey: .postId)
                sizes = try values.decodeIfPresent([Size].self, forKey: .sizes)
                text = try values.decodeIfPresent(String.self, forKey: .text)
        }

}

struct Size : Codable {

    var height : Int?
    var type : String?
    var url : String?
    var width : Int?

        enum CodingKeys: String, CodingKey {
                case height = "height"
                case type = "type"
                case url = "url"
                case width = "width"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                height = try values.decodeIfPresent(Int.self, forKey: .height)
                type = try values.decodeIfPresent(String.self, forKey: .type)
                url = try values.decodeIfPresent(String.self, forKey: .url)
                width = try values.decodeIfPresent(Int.self, forKey: .width)
        }

}
