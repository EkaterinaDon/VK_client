//
//  MyGroupsTableViewController.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class MyGroupsTableViewController: UITableViewController {
    
    
    var myGroups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        generateGroups()
    }
    
    private func generateGroups() {
        let group1 = Group(name: "Spiders from Mars", imageName: "spiders")
        let group2 = Group(name: "The Hipe", imageName: "Hipe")
        let group3 = Group(name: "Tin Machine", imageName: "tin")
        myGroups.append(group1)
        myGroups.append(group2)
        myGroups.append(group3)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as! MyGroupsTableViewCell
        let group = myGroups[indexPath.row]
        
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
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //удаляем группу и строку
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    
    
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
