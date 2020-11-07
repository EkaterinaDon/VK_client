//
//  NewsViewController.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 31/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit


class NewsModel {
    
    static let instance = NewsModel()
    
    var allNews: [News] = []
    
    var groupNews: [NewsFromGroup] = []
    
    var profileNews: [Profile] = []
    
}

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var newsServise = NewsService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.newsServise.getNews(user_id: Session.instance.userId) { [weak self] allNews, groupNews, profileNews  in
                
                DispatchQueue.main.async {
                    NewsModel.instance.allNews = allNews
                    NewsModel.instance.groupNews = groupNews
                    NewsModel.instance.profileNews = profileNews
                    self!.table.reloadData()
                }
            }
            
        }
        
        table.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
        
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        
    }
    
    // MARK: - Table view data source
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return NewsModel.instance.allNews.count //allNews.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        
//        let profile = NewsModel.instance.profileNews[indexPath.row]
//        let group = NewsModel.instance.groupNews[indexPath.row]
        let new = NewsModel.instance.allNews[indexPath.row]

        let date = Date(timeIntervalSince1970: new.date!)
        let stringDate = NewsTableViewCell.dateFormatter.string(from: date)
        cell.dateLabel.text = stringDate

        cell.newsLabel.text = new.text
        
//        if new.sourceId == profile.id {
//            cell.nameLabel.text = profile.name
//        } else if new.sourceId == group.id {
//            cell.nameLabel.text = group.name
//        }
        
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
