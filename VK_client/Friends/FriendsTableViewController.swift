//
//  FriendsTableViewController.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit
import RealmSwift
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FriendsForSections: Comparable {
    
  var sectionKey: String.Element?
    var rowValue: [FriendFireStore]
    
   
    
    static func < (lhs: FriendsForSections, rhs: FriendsForSections) -> Bool {
        return (lhs.sectionKey!) < rhs.sectionKey!
    }
    static func == (lhs: FriendsForSections, rhs: FriendsForSections) -> Bool {
        return lhs.sectionKey == rhs.sectionKey
    }
    
}


class FriendsTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
//    var myFriends: Results<Friend>?
    let ref = Firestore.firestore().collection("friends")
    var friendsService = FriendsService()
    var myFriends = [FriendFireStore]()
    var sections = [FriendsForSections]()
    var searchResults = [FriendsForSections]()
    var searching: Bool = false
//    var token: NotificationToken?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = .clear
        self.tableView.sectionIndexBackgroundColor = .clear
        
        searchBar.delegate = self
        
        setTableViewBackgroundGradient(sender: self)
        
        searchBar.barTintColor =  #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 0.8763162494) 
        
        
       // friendsFromRealm()
        friendsService.getFriend(user_id: Session.instance.userId)
        loadFriendsFromFireStore()
        listener()

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
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = self.getGradientBackgroundView()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if searching {
            let section = searchResults[section]
            let letter = section.sectionKey
            label.text = letter!.uppercased()
            headerView.addSubview(label)
            label.leftAnchor.constraint(equalTo: headerView.leftAnchor).isActive = true
            label.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 25).isActive = true
            return headerView
        } else {
            let section = self.sections[section]
            let letter = section.sectionKey
            label.text = letter!.uppercased()
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
        return sections.map{String(($0.sectionKey!))}
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: UITableView.ScrollPosition.top , animated: false)
        return index
        
    }
    
    
    
    
    
    // MARK: - segue
    
    // MARK: - prepare forFriendsPhotoCollection
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let friendsPhotoCollection = segue.destination as? FriendsPhotoCollection {
            if let indexPath = tableView.indexPathForSelectedRow {
                let section = self.sections[indexPath.section]
                let friend = section.rowValue[indexPath.row]
                friendsPhotoCollection.friend = friend
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
            (FriendsForSections.sectionKey!.lowercased().contains(searchText.lowercased()))
        })
        searching = true
        self.tableView.reloadData()
    }
    
    //  MARK: - градиент для Hiader
    func getGradientBackgroundView() -> UIView {
        let gradientBackgroundView = UIView()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = CGSize(width: self.tableView.frame.size.width, height: 28)
        gradientLayer.startPoint = CGPoint(x: 0.7, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: -0.45, y: 0.5)
        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.white.cgColor]
        
        gradientBackgroundView.layer.addSublayer(gradientLayer)
        return gradientBackgroundView
    }
    
    //градиент для tableview
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
    
    // MARK: - FireStore
    func loadFriendsFromFireStore() {
        ref.getDocuments { [weak self] (querySnapshot, error) in
                if let snapshotDocuments = querySnapshot?.documents {
                    for document in snapshotDocuments {
                        do {
                            if let friend = try document.data(as: FriendFireStore.self) {
                                self!.myFriends.append(friend)
                            }
                        } catch let error as NSError {
                            print("error: \(error.localizedDescription)")
                        }
                    }
                    let group = Dictionary(grouping: self!.myFriends, by: { $0.first_name.first })
                    self!.sections = group.map(FriendsForSections.init(sectionKey: rowValue:)).sorted()
                    self!.tableView.reloadData()
                }
            }
    }
    

    func listener() {
        let listener = ref.addSnapshotListener { (snapshot, error) in
            switch (snapshot, error) {
            case (.none, .none):
                print("no data")
            case (.none, .some(let error)):
                print("some error \(error.localizedDescription)")
            case (.some(let snapshot), _):
                print("collection updated, now it contains \(snapshot.documents.count) documents")
            }
        }
        
    }
    
    
    // MARK: - Realm
//    func friendsFromRealm() {
//        guard let realm = try? Realm() else { return }
//        myFriends = realm.objects(Friend.self)
//
//        self.token = myFriends!.observe { [weak self] (changes: RealmCollectionChange) in
//            guard let tableView = self?.tableView else { return }
//            switch changes {
//            case .initial:
//                tableView.reloadData()
//            case .update(_, let deletions, let insertions, let modifications):
//                tableView.beginUpdates()
//                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
//                                     with: .automatic)
//                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }),
//                                     with: .automatic)
//                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
//                                     with: .automatic)
//                tableView.endUpdates()
//            case .error(let error):
//                fatalError("\(error)")
//            }
//        }
//    }
    
    
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




