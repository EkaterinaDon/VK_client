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


class FriendsTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    let myFriends = Friends.generateFriends()
    var sections = [FriendsForSections]()
    var searchResults = [FriendsForSections]()
    var searching: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = Dictionary(grouping: self.myFriends, by: { $0.name.first })
        self.sections = group.map(FriendsForSections.init(sectionKey: rowValue:)).sorted()
        
        
        self.tableView.separatorColor = .clear
        self.tableView.sectionIndexBackgroundColor = .clear
        
        searchBar.delegate = self
        
        setTableViewBackgroundGradient(sender: self)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searching {
            return searchResults.count
        } else {
            return self.sections.count
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            let section = searchResults[section]
            return section.rowValue.count
        } else {
            let section = self.sections[section]
            return  section.rowValue.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
        cell.backgroundColor = .clear
        
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(imgTapped(sender:)))
        cell.friendsImage.addGestureRecognizer(tapImage)
        cell.friendsImage.isUserInteractionEnabled = true
        
        if searching {
            let section = searchResults[indexPath.section]
            let friend = section.rowValue[indexPath.row]
            cell.configure(for: friend)
            return cell
        } else {
            let section = self.sections[indexPath.section]
            let friend = section.rowValue[indexPath.row]
            cell.configure(for: friend)
            return cell
        }
        
    }
    
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        let section = self.sections[section]
    //        let letter = section.sectionKey
    //        return letter?.uppercased()
    //    }
    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = self.getGradientBackgroundView()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if searching {
            let section = searchResults[section]
            let letter = section.sectionKey
            label.text = letter?.uppercased()
            headerView.addSubview(label)
            label.leftAnchor.constraint(equalTo: headerView.leftAnchor).isActive = true
            label.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 25).isActive = true
            return headerView
        } else {
            let section = self.sections[section]
            let letter = section.sectionKey
            label.text = letter?.uppercased()
            headerView.addSubview(label)
            label.leftAnchor.constraint(equalTo: headerView.leftAnchor).isActive = true
            label.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 25).isActive = true
            
            return headerView
        }
    }
    
    // MARK: - alfabet search
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map{String(($0.sectionKey)!)}
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: UITableView.ScrollPosition.top , animated: false)
        return index
        
    }
    
    
    
    
    
    // MARK: - segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let friendsCollectionViewController = segue.destination as? FriendsCollectionViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let section = self.sections[indexPath.section]
                let friend = section.rowValue[indexPath.row]
                friendsCollectionViewController.friend = friend
            }
        }
        
    }
    
    
    // MARK: - Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            searchResults = sections
            tableView.reloadData()
            return
        }
        searchResults = sections.filter({ (FriendsForSections) -> Bool in
            (FriendsForSections.sectionKey?.lowercased().contains(searchText.lowercased()))!
        })
        searching = true
        self.tableView.reloadData()
    }
    
    private func getGradientBackgroundView() -> UIView {
        let gradientBackgroundView = UIView()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = CGSize(width: self.tableView.frame.size.width, height: 28)
        gradientLayer.startPoint = CGPoint(x: 0.7, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: -0.45, y: 0.5)
        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.white.cgColor]
        
        gradientBackgroundView.layer.addSublayer(gradientLayer)
        return gradientBackgroundView
    }
    
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
    
    
    // MARK: - TableView animation
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, +70, 15, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 0.7) {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    @objc func imgTapped(sender: UITapGestureRecognizer) {
        
        //print("tapped")
        
        guard sender.view != nil else { return }
        
        if sender.state == .ended {
            
            let animation = CASpringAnimation(keyPath: "transform.scale")
            animation.fromValue = 1
            animation.toValue = 1.3
            animation.stiffness = 200
            animation.mass = 2
            animation.duration = 0.5
            animation.beginTime = CACurrentMediaTime()
            animation.fillMode = CAMediaTimingFillMode.backwards
            animation.autoreverses = true
            
            sender.view!.layer.add(animation, forKey: nil)
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




