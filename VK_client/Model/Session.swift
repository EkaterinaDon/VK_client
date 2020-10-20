//
//  Session.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 22/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class Session {
    
    static let instance = Session()
    
    var token: String = ""
    let userId: String = "7609950"
    
    private init() {}
}
