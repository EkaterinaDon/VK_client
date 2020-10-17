//
//  UserPhotos.swift
//  VK_client
//
//  Created by Ekaterina on 14.10.20.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - PhotosResponse
class PhotosResponse: Decodable {
    let response: ResponsePhoto
}

// MARK: - ResponsePhoto
class ResponsePhoto: Decodable {
    let count: Int
    let items: [Photos]
}

// MARK: - Item
class Photos: Decodable {
     var sizes: [Size] = []
   

//    enum CodingKeys: String, CodingKey {
//        case sizes
//    }
    
//    convenience required init(from decoder: Decoder) throws {
//        self.init()
//        let value = try decoder.container(keyedBy: CodingKeys.self)
//        self.sizes = try value.decode([Size].self, forKey: .sizes)
//    }
    
    class Size: Decodable {
        var url: String = ""
        
    }
    
    enum CodingKeys: String, CodingKey {
        case sizes
        
        enum NextCodingKeys: String, CodingKey {
            case url
        }
    }
    
    
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.sizes = try value.decode([Size].self, forKey: .sizes)
        let nextValue = try value.nestedContainer(keyedBy: CodingKeys.NextCodingKeys.self, forKey: .sizes)
        _ = try nextValue.decode(String.self, forKey: .url)
    }
}

// MARK: - Size
//class Size: Decodable {
//    var url: String = ""
//
//    enum CodingKeys: String, CodingKey {
//        case url
//    }
//
//    convenience required init(from decoder: Decoder) throws {
//        self.init()
//        let value = try decoder.container(keyedBy: CodingKeys.self)
//        self.url = try value.decode(String.self, forKey: .url)
//    }
//}
