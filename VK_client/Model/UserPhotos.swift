//
//  UserPhotos.swift
//  VK_client
//
//  Created by Ekaterina on 14.10.20.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import RealmSwift

class PhotosResponse : Decodable {

    var photosResponse : ResponsePhoto?

    enum CodingKeys: String, CodingKey {
        case photosResponse = "response"
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //photosResponse = try ResponsePhoto(from: decoder)
        self.photosResponse = try values.decodeIfPresent(ResponsePhoto.self, forKey: .photosResponse)
    }

}

class ResponsePhoto : Decodable {

    var count : Int = 0
    var items : [Item]?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case items = "items"
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try values.decode(Int.self, forKey: .count)
        self.items = try values.decode([Item].self, forKey: .items)
    }

}

class Item : Decodable {

    var ownerId : Double = 0
    var sizes : [Photos]?

    enum CodingKeys: String, CodingKey {
        case ownerId = "owner_id"
        case sizes = "sizes"

    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.ownerId = try values.decode(Double.self, forKey: .ownerId)
        self.sizes = try values.decode([Photos].self, forKey: .sizes)

    }

}

class Photos : Decodable {

    var url : String = ""

    enum CodingKeys: String, CodingKey {
        case url = "url"
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try values.decode(String.self, forKey: .url)

    }

}
