//
//  VKApiLoggingProxy.swift
//  VK_client
//
//  Created by Ekaterina on 15.01.21.
//  Copyright © 2021 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class VKApiLoggingProxy: VKApiInterface {
    
    let vkApiService: VKApiInterface = FriendsService()
    
    func getFriend() -> Promise<[Friend]> {
        log("getFriendsLog")
        return vkApiService.getFriend()
    }

    private func log(_ text: String) {
        print(text)
    }
}
