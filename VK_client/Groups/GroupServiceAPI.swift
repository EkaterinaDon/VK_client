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

class GroupService: Operation {
    
    let baseUrl = "https://api.vk.com"

    func getGroup(user_id: String) {
            let path = "/method/groups.get"
            let parameters: Parameters = [
                Session.instance.userId: user_id,
                "extended": "1",
                "fields": ["name", "photo_50"],
                "method": "groups.get",
                "access_token": Session.instance.token,
                "v": "5.124"
            ]
            
            let url = baseUrl+path
       
//                AF.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
//                    guard let data = response.value else { return }
//                    let group = try! JSONDecoder().decode(GroupResponse.self, from: data).response.items
//                    self?.saveGroups(group)
//                }
        let operationQueue = OperationQueue()
        let request = AF.request(url, method: .get, parameters: parameters)
           
                            
        let operation = GetDataOperation(request: request)
        operationQueue.addOperation(operation)
        
        let parseData = ParseData()
        parseData.addDependency(operation)
        operationQueue.addOperation(parseData)
        
        let saveGroups = SaveGroups()
        self.addDependency(parseData)
        operationQueue.addOperation(saveGroups)
        
        let reloadTableController = ReloadTableController()
        reloadTableController.addDependency(parseData)
        OperationQueue.main.addOperation(reloadTableController)
        
    }
    


    func saveGroups(_ groups: [Group]) {

        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)

            let oldGroups = realm.objects(Group.self)
            realm.beginWrite()
            realm.delete(oldGroups)
            realm.add(groups)
            //debugPrint(realm.configuration.fileURL!)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
}


class ParseData: Operation {

    var outputData: [Group] = []

    override func main() {
        guard let getOperation = self.dependencies.first as? GetDataOperation,
              let data = getOperation.data else { return }
        let group = try! JSONDecoder().decode(GroupResponse.self, from: data).response.items
        outputData = group
    }
}

class SaveGroups: Operation {
    
    override func main() {
        guard let parseData = dependencies.first as? ParseData else { return }
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)

            let oldGroups = realm.objects(Group.self)
            realm.beginWrite()
            realm.delete(oldGroups)
            realm.add(parseData.outputData)
            //debugPrint(realm.configuration.fileURL!)
            try realm.commitWrite()
        } catch {
            print(error)
        }
       
        
      }

}

class ReloadTableController: Operation {
    var controller: MyGroupsTableViewController?

    override func main() {
        guard let _ = dependencies.first as? SaveGroups else { return }
        controller!.tableView.reloadData()
  
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
