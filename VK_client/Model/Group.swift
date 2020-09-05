//
//  Group.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation

struct Group {
    let name: String
    let imageName: String
}

extension Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.imageName == rhs.imageName
           
    }
}
