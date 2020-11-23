//
//  NewsViewController.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 31/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var table: UITableView!
    
    var newsServise = NewsService()
    var allNews: [News] = []
    var newsPhotos: [String] = []
    let refreshControl = UIRefreshControl()
    var nextFrom = ""
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.newsServise.getNews(user_id: Session.instance.userId, startFrom: "20.11.2019") { [weak self] allNews, nextFrom  in
            self?.allNews = allNews
            self?.nextFrom = nextFrom
            self!.table.reloadData()
        }
        
         newsPhotos = allNews.compactMap { $0.attachments }.reduce([], +).compactMap { $0.photo }.compactMap { $0.sizes }.reduce([], +).compactMap { $0.url }
        
        setupRefreshControl()
        
        table.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
        table.prefetchDataSource = self
        
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        
        
    }
    
    // MARK: - Table view data source
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNews.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        
        let new = allNews[indexPath.row]
               
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

    // MARK: - RefreshControl
    
    fileprivate func setupRefreshControl() {
        
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        table.refreshControl = refreshControl
        
    }
    
    @objc func refreshNews() {
        
        self.refreshControl.beginRefreshing()
        
        let mostFreshNewsDate = allNews.first?.date ?? Date().timeIntervalSince1970
        // отправляем сетевой запрос загрузки новостей
        newsServise.getNews(user_id: Session.instance.userId, startFrom: "21.11.2019", startTime: mostFreshNewsDate + 1) { [weak self] allNews, nextFrom in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
            // проверяем, что более свежие новости действительно есть
            guard allNews.count > 0 else { return }
            // прикрепляем их в начало отображаемого массива
            self.allNews = allNews + self.allNews
            self.nextFrom = nextFrom
            // формируем IndexSet свежедобавленных секций и обновляем таблицу
            let indexSet = IndexSet(integersIn: 0..<self.allNews.count)
            //self.table.insertSections(indexSet, with: .automatic)
            //self.table.insertRows(at: indexSet, with: .automatic)
            
        }
        
    }
    
    private func makeIndexSet(lastIndex: Int, _ newsCount: Int) -> [IndexPath] {
        let last = lastIndex + newsCount
        let indexPaths = Array(lastIndex + 1...last).map { IndexPath(row: $0, section: 0) }
        
        return indexPaths
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

extension NewsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard !isLoading else { return }

        for indexPath in indexPaths {
        if indexPath.row == allNews.count - 1 {
            isLoading = true
            let lastIndex = indexPath.row
            newsServise.getNews(user_id: Session.instance.userId, startFrom: nextFrom) { [weak self] allNews, nextFrom  in
                guard let self = self else { return }
                self.allNews.append(contentsOf: allNews)
                self.nextFrom = nextFrom
                let indexPaths = self.makeIndexSet(lastIndex: lastIndex, allNews.count)
                self.table.insertRows(at: indexPaths, with: .automatic)
                self.isLoading = false
            }
        }
    }
 }
}
