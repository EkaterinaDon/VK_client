//
//  MyGroupsTableViewController.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class MyGroupsTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var searchController: UISearchController!
    
    var groupService = GroupService()
    var myGroups: [Group] = []
    var searchResults: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupService.getGroup(user_id: "6492") { [weak self] myGroups in
            self?.myGroups = myGroups
            
            self?.tableView.reloadData()
        }
        
        
        
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
        return myGroups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as! MyGroupsTableViewCell
        let group = (searchController.isActive) ? searchResults[indexPath.row] : myGroups[indexPath.row]
        
        cell.configure(for: group)
        
        return cell
    }
    
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        //проверяем что переход активирован
        if segue.identifier == "addGroup" {
            guard let availableGroupsTableViewController = segue.source as? AvailableGroupsTableViewController else { return }
            //получаем индекс ячейки
            if let indexPath = availableGroupsTableViewController.tableView.indexPathForSelectedRow {
                //получаем группу
                let group = availableGroupsTableViewController.availableGroups[indexPath.row]
                //проверяем что группа еще не была добавлена
                if !myGroups.contains(group) {
                    //добавляем группу
                    myGroups.append(group)
                    //обновляем экран
                    tableView.reloadData()
                    
                }
                
            }
        }
        
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //удаляем группу и строку
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    
    // MARK: - search
    func filterContent(for searchText: String) {
        searchResults = myGroups.filter({ (group) -> Bool in
            let name = group.name
            let isMatch = name.localizedCaseInsensitiveContains(searchText)
            return isMatch
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
}

extension MyGroupsTableViewController {
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
