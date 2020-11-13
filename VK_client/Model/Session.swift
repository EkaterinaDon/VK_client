//
//  Session.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 22/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class Session {
    
    static let instance = Session()
    
    var token: String {
        get {
            KeychainWrapper.standard.string(forKey: "vkToken") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "vkToken")
        }
    }
    var userId: String { //7609950
        get {
            KeychainWrapper.standard.string(forKey: "vkUserId") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "vkUserId")
        }
    }
    
//    func eraseAll() {
//        KeychainWrapper.standard.removeAllKeys()
//    }
    
    private init() {}
}
