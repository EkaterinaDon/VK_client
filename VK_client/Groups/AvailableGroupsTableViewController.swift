//
//  AvailableGroupsTableViewController.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class AvailableGroupsTableViewController: UITableViewController {
    
    var availableGroups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        generateGroups()
        setTableViewBackgroundGradient(sender: self)
    }
    
    private func generateGroups() {
        let group1 = Group(name: "The Arnold Corns", imageName: "arnoldCorns")
        let group2 = Group(name: "The Manish Boys", imageName: "manishBoys")
        let group3 = Group(name: "The Lower Third", imageName: "lowerThird")
        let group4 = Group(name: "The King Bees", imageName: "kingBees")
        availableGroups.append(group1)
        availableGroups.append(group2)
        availableGroups.append(group3)
        availableGroups.append(group4)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return availableGroups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableGroupsCell", for: indexPath) as! AvailableGroupsTableViewCell
        
        let availableGroup = availableGroups[indexPath.row]
        
        cell.configure(for: availableGroup)
        
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
