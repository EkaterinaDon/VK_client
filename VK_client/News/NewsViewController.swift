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

    func newsOwner() {
        for item in allNews {
            if item.sourceId >= 0 {
                for profile in profileNews {
                    if item.sourceId == profile.id {
                        item.newsName = profile.name
                        item.newsPhoto = profile.photo50!
                    }
                }
            } else {
                for group in groupNews {
                    if abs(item.sourceId) == group.id {
                        item.newsName = group.name
                        item.newsPhoto = group.photo50!
                    }
                }
            }
        }
    }

}

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var newsServise = NewsService()


    override func viewDidLoad() {
        super.viewDidLoad()
        
    
            self.newsServise.getNews(user_id: Session.instance.userId) { [weak self] allNews, groupNews, profileNews  in
                    NewsModel.instance.allNews = allNews
                    NewsModel.instance.groupNews = groupNews
                    NewsModel.instance.profileNews = profileNews
                    self!.table.reloadData()            
        }
        
        table.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
        
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        
        
    }
    
    // MARK: - Table view data source
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsModel.instance.allNews.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        
        NewsModel.instance.newsOwner()
        let new = NewsModel.instance.allNews[indexPath.row]
        
        let date = Date(timeIntervalSince1970: new.date!)
        let stringDate = NewsTableViewCell.dateFormatter.string(from: date)
        cell.dateLabel.text = stringDate
        
        cell.newsLabel.text = new.text
        cell.nameLabel.text = new.newsName
        
        let url = URL(string: new.newsPhoto)
        
        UIImage.loadNewsImage(url: url!) { image in
            cell.photoImage.image = image
            }

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


extension UIImage {

    public static func loadNewsImage(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

}
