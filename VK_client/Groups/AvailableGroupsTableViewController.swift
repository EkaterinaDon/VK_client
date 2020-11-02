//
//  AvailableGroupsTableViewController.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit
import RealmSwift

class AvailableGroupsTableViewController: UITableViewController {
    
    var searchController: UISearchController!
    
    var groupService = SearchGroupService()
    var availableGroups: Results<SearchResult>?
    var searchResults: [SearchResult] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var previousRun = Date()
    let minInterval = 0.05
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupSearchFromRealm()
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        
        setTableViewBackgroundGradient(sender: self)
        searchController.searchBar.barTintColor =  #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 0.8763162494)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searchController.isActive { return searchResults.count }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive { return searchResults.count }
        return availableGroups!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableGroupsCell", for: indexPath) as! AvailableGroupsTableViewCell
        
//        let availableGroup = (searchController.isActive) ? searchResults[indexPath.row] : availableGroups![indexPath.row]
        
        if searchController.isActive &&  searchResults.isEmpty {
            let availableGroup = availableGroups![indexPath.row]
            cell.configure(for: availableGroup)
        } else if searchController.isActive && !searchResults.isEmpty {
            let availableGroup = searchResults[indexPath.row]
            cell.configure(for: availableGroup)
        } else {
            let availableGroup = availableGroups![indexPath.row]
            cell.configure(for: availableGroup)
        }

        return cell
    }
    
    
    // MARK: - Realm
    func groupSearchFromRealm() {
        guard let realm = try? Realm() else { return }
        availableGroups = realm.objects(SearchResult.self)
        self.token = availableGroups!.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
        }
    }
    }

}

extension AvailableGroupsTableViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults.removeAll()
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            return
        }
        if Date().timeIntervalSince(previousRun) > minInterval {
            previousRun = Date()
            fetchResults(for: textToSearch)
        }
    }
    
    func fetchResults(for text: String) {
        groupService.searchGroup(user_id: Session.instance.userId, searchText: text) { [weak self] searchResults in
            self?.searchResults = searchResults
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults.removeAll()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let textToSearch = searchController.searchBar.text {
            fetchResults(for: textToSearch)
            tableView.reloadData()
        }
    }
}

extension AvailableGroupsTableViewController {
func setTableViewBackgroundGradient(sender: UITableViewController) {
    
    let backgroundView = UIView(frame: sender.tableView.bounds)
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.white.cgColor]
    
    gradientLayer.startPoint = CGPoint(x: -0.45, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.5)
    gradientLayer.frame = sender.tableView.bounds
    backgroundView.layer.insertSublayer(gradientLayer, at: 0)
    sender.tableView.backgroundView = backgroundView
    }
}
