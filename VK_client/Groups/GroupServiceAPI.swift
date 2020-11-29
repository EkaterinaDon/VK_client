//
//  GroupServiceAPI.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 27/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class GroupService: AsyncOperation {
    
    let baseUrl = "https://api.vk.com"
    
    func getGroup() {
        let path = "/method/groups.get"
        let parameters: Parameters = [
            "user_id": Session.instance.userId,
            "extended": "1",
            "fields": ["name", "photo_50"],
            "method": "groups.get",
            "access_token": Session.instance.token,
            "v": "5.124"
        ]
        
        let url = baseUrl+path
        
        let operationQueue = OperationQueue()
        let request = AF.request(url, method: .get, parameters: parameters)
        
        operationQueue.qualityOfService = .userInteractive
        
        let operation = GetDataOperation(request: request)
        let parseData = ParseData()
        parseData.addDependency(operation)
        let saveGroups = SaveGroups()
        saveGroups.addDependency(parseData)
        
        operationQueue.addOperations([operation, parseData, saveGroups], waitUntilFinished: true)
        
    }
        
}

class GetDataOperation: AsyncOperation {
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    
    private var request: DataRequest
    var data: Data?
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
    
    init(request: DataRequest) {
        self.request = request
    }
    
}


class ParseData: Operation {
    
    var outputData: [Group]?
    
    override func main() {
        guard let getOperation = dependencies.first as? GetDataOperation,
              let data = getOperation.data else { return }
        let group = try! JSONDecoder().decode(GroupResponse.self, from: data).response.items
        outputData = group
    }
    
}

class SaveGroups: Operation {
    
    override func main() {
        guard let parseData = dependencies.first as? ParseData,
              let group = parseData.outputData else { return }
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            
            let oldGroups = realm.objects(Group.self)
            realm.beginWrite()
            realm.delete(oldGroups)
            realm.add(group)
            try realm.commitWrite()
        } catch {
            print(error)
        }
        
    }
    
}

class AsyncOperation: Operation {
    enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    override var isFinished: Bool {
        return state == .finished
    }
    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }
    override func cancel() {
        super.cancel()
        state = .finished
    }
}

