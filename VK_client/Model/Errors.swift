//
//  Errors.swift
//  VK_client
//
//  Created by Ekaterina on 13.11.20.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation


struct ApiEror: Decodable {
    let error: ApiError

    enum CodingKeys: String, CodingKey {
        case error = "error"
    }
}

// MARK: - Error
struct ApiError: Decodable {
    let errorCode: Int
    let errorMsg: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMsg = "error_msg"
    }
}

enum VKError: Error, LocalizedError {
    case uknown
    
    var errorDescription: String? {
        return "check up internet connection"
    }
}
