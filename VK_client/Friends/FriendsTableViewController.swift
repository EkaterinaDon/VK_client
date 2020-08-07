//
//  FriendsTableViewController.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    var myFriends: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateFriends()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    private func generateFriends() {
        let friend1 = Friend(name: "Ziggy Stardust", imageName: "ziggy")
        let friend2 = Friend(name: "Major Tom", imageName: "majorTom")
        let friend3 = Friend(name: "Halloween Jack", imageName: "halloweenJack")
        let friend4 = Friend(name: "Aladdin Sane", imageName: "aladdinSane")
        let friend5 = Friend(name: "The Thin White Duke", imageName: "whiteDuke")
        let friend6 = Friend(name: "Pierrot", imageName: "pierrot")
        let friend7 = Friend(name: "The Soul Man", imageName: "soulMan")
        let friend8 = Friend(name: "Screaming Lord Byron", imageName: "lordByron")
        let friend9 = Friend(name: "Jareth the Goblin King", imageName: "goblinKing")
        let friend10 = Friend(name: "The DJ", imageName: "dj")
        let friend11 = Friend(name: "The Blind Prophet", imageName: "blindProphet")
        myFriends.append(friend1)
        myFriends.append(friend2)
        myFriends.append(friend3)
        myFriends.append(friend4)
        myFriends.append(friend5)
        myFriends.append(friend6)
        myFriends.append(friend7)
        myFriends.append(friend8)
        myFriends.append(friend9)
        myFriends.append(friend10)
        myFriends.append(friend11)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myFriends.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
        
        //получаем друга для строки
        let friend = myFriends[indexPath.row]
        
        //устанавливаем друга в ячейку
        cell.configure(for: friend)
        
        return cell
    }
    
    
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
