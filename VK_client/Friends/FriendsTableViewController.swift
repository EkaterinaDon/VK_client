//
//  FriendsTableViewController.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

struct FriendsForSections: Comparable {
    
    var sectionKey: String.Element?
    var rowValue: [Friend]
    
    static func < (lhs: FriendsForSections, rhs: FriendsForSections) -> Bool {
        return (lhs.sectionKey)! < rhs.sectionKey!
    }
    static func == (lhs: FriendsForSections, rhs: FriendsForSections) -> Bool {
        return lhs.sectionKey == rhs.sectionKey
    }
    
}


class FriendsTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
   
    
    var searchController:UISearchController!
    
    let myFriends = Friends.generateFriends()
    var searchResults:[Friend] = []
    var sections = [FriendsForSections]()
   
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        
        let group = Dictionary(grouping: self.myFriends, by: { $0.name.first })
        self.sections = group.map(FriendsForSections.init(sectionKey: rowValue:)).sorted()
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
            
    }
    


    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searchController.isActive { return searchResults.count }
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive { return searchResults.count }
        let section = self.sections[section]
        
        return  section.rowValue.count
   }

        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
        
         let section = self.sections[indexPath.section]
        
        //получаем друга для строки
        let friend = (searchController.isActive) ? searchResults[indexPath.row] : section.rowValue[indexPath.row]
        
        //устанавливаем друга в ячейку

        cell.configure(for: friend)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchController.isActive { return nil }
        let section = self.sections[section]
        let letter = section.sectionKey
        return letter?.uppercased()
    }
    
     // MARK: - alfabet search
    
    func getLetters() -> [String] {
         var letters: [String] = []
         for friend in myFriends {
             let name = friend.name
             let firstLetter = name.first
             let first = firstLetter?.uppercased()
            if !letters.contains(first!) {
            letters.append(first!)
            }
         }
                
        return letters
     }
     
     
     override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
         if searchController.isActive { return nil }
        return getLetters()
     }
     
     override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
         if searchController.isActive { return 0 }
         tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: UITableView.ScrollPosition.top , animated: false)
         return getLetters().firstIndex(of: title)!
         
     }
     

    
    // MARK: - segue
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let friendsCollectionViewController = segue.destination as? FriendsCollectionViewController {
               if let indexPath = tableView.indexPathForSelectedRow {
                let section = self.sections[indexPath.section]
                let friend = section.rowValue[indexPath.row]
                   friendsCollectionViewController.friend = (searchController.isActive) ? searchResults[indexPath.row] : friend
               }
           }
   
       }
    
    
    // MARK: - search
    func filterContent(for searchText: String) {
        searchResults = myFriends.filter({ (friend) -> Bool in
             let name = friend.name
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
    
        
      // MARK: - TableView delegate
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let whichIsSelected = indexPath.row
//        let selectedFriend = myFriends[whichIsSelected] //обернуть в guard
//        let friendsCollectionViewController = storyboard?.instantiateViewController(identifier: "friendsCollectionViewControllerKey") as! FriendsCollectionViewController
//        friendsCollectionViewController.friend = selectedFriend
//        self.show(friendsCollectionViewController, sender: nil)
//    }
//    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}




