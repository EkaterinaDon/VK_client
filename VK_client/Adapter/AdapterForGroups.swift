//
//  AdapterForGroups.swift
//  VK_client
//
//  Created by Ekaterina on 23.12.20.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import RealmSwift

final class AdapterForGroups {
    
    private let groupService = GroupService()
    private var realmNotificationTokens: [String: NotificationToken] = [:]
    
    func getGroups(completion: @escaping ([Group]) -> Void) {
        guard let realm = try? Realm(), let realmGroup = realm.object(ofType:Group.self, forPrimaryKey: Group.primaryKey())
            else { return }
        
        self.realmNotificationTokens[Group.primaryKey()]?.invalidate()
        
        let token = realmGroup.groups.observe{ [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .update(let realmGroups, _, _, _):
                var groups: [Groups] = []
                realmGroups.forEach { (rGroup) in
                    groups.append(self.getGroup(from: realmGroup))
                }
                
                completion(groups)
            case .error(let error):
                fatalError("\(error)")
            case .initial:
                break
            }
        }
        self.realmNotificationTokens[Group.primaryKey()] = token
        
        groupService.getGroup()
    }
    
    private func getGroup(from realmGroup: Group) -> Groups {
        return Groups(id: realmGroup.id, name: realmGroup.name, photo: realmGroup.photo)
    }
}


