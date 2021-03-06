//
//  NewsTableViewCell.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 31/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "NewsTableViewCell"
    
    var newsViewController = NewsViewController()
    var newsPhotos: [PhotoForNews] = [] {  
        didSet {
            newsCollectionView?.reloadData()
        }
    }
  
    
    static func nib() -> UINib {
        return UINib(nibName: "NewsTableViewCell", bundle: nil)
    }
    
    @IBOutlet private weak var newsCollectionView: UICollectionView! 
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var newsLabel: UILabel!
    
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var showMoreButton: UIButton!
    
    @IBAction func showMore(sender: UIButton) {

        if newsLabel.numberOfLines == 1 {
            showMoreButton.setTitle("Show less", for: UIControl.State.normal)
            newsLabel.numberOfLines = 0

        } else {
            showMoreButton.setTitle("Show More...", for: UIControl.State.normal)
            newsLabel.numberOfLines = 1
        }

        newsViewController.table?.reloadData()
    }
    
    static let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "dd.MM.yyyy HH.mm"
            return df
        }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsCollectionView.register(NewsCollectionViewCell.nib(), forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
       
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        
        //let layout = UICollectionViewFlowLayout()
        //layout.scrollDirection = .horizontal
       // newsCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
     
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debugPrint(newsPhotos.count)
        guard !newsPhotos.isEmpty else { return 0 }
        let photos = newsPhotos[section]
        return  photos.url!.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as! NewsCollectionViewCell
        guard !newsPhotos.isEmpty else { return cell }
        let photos = newsPhotos[indexPath.row]
        
        guard let url = URL(string: photos.url!) else { return cell }
        UIImage.loadPhotos(url: url) { image in
            cell.newsImage.image = image
            }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250) //CGSize(width: self.bounds.width, height: self.bounds.height)
    }
    
}


