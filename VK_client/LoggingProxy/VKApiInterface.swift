//
//  VKApiInterface.swift
//  VK_client
//
//  Created by Ekaterina on 15.01.21.
//  Copyright © 2021 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

protocol VKApiInterface {

    func getFriend() -> Promise<[Friend]>
}

