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
    var photoForNews: [PhotoForNews] = []
    let refreshControl = UIRefreshControl()
    var nextFrom = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDotsAnimation()
        
        self.newsServise.getNews() { [weak self] allNews, photoForNews, nextFrom in
            self?.allNews = allNews
            self?.photoForNews = photoForNews
            self?.nextFrom = nextFrom ?? ""
            let newsTableViewCell = NewsTableViewCell()
            newsTableViewCell.newsPhotos = photoForNews
            debugPrint(newsTableViewCell.newsPhotos.count)
            self!.table.reloadData()
        }
        
        setupRefreshControl()
        
        table.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
        
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 600
        
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
        
        UIImage.loadPhotos(url: url!) { image in
            cell.photoImage.image = image
            }
        
        cell.showMoreButton.tag = indexPath.row
        cell.layoutSubviews()

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600 
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
        newsServise.getNews(startTime: mostFreshNewsDate + 1) { [weak self] allNews, photoForNews, nextFrom in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
            guard allNews.count > 0 else { return }
            self.allNews = allNews + self.allNews
            self.photoForNews = photoForNews + self.photoForNews
            self.table.reloadData()
        }
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (table.contentSize.height - 100 - scrollView.frame.size.height) {
            guard !newsServise.isLoading else { return }
            self.table.tableFooterView = createSpinnerFooter()
            newsServise.getNews(startFrom: nextFrom) { [weak self] allNews, photoForNews, nextFrom  in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.table.tableFooterView = nil
                }
                self.allNews.append(contentsOf: allNews)
                self.photoForNews.append(contentsOf: photoForNews)
                self.nextFrom = nextFrom ?? ""
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            }
        } else if position < (table.contentSize.height + 100 + scrollView.frame.size.height) {
            guard !newsServise.isLoading else { return }
            refreshNews()
        }
    }
    
    // MARK: - Dots Animation
        func startDotsAnimation() {
            indicatorView.shared.showOverlay(self.view, dots_color: UIColor.lightGray, bg_color: UIColor.black, dots_count: 2)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                indicatorView.shared.hideOverlayView()
            }
        }
}

