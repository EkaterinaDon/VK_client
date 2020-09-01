//
//  NewsTableViewCell.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 31/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "NewsTableViewCell"
      
      static func nib() -> UINib {
          return UINib(nibName: "NewsTableViewCell", bundle: nil)
      }

    @IBOutlet var newsCollectionView: UICollectionView!
    
    @IBOutlet weak var nameLabel: UILabel!
     
     @IBOutlet weak var dateLabel: UILabel!
     
     @IBOutlet weak var newsLabel: UILabel!
     
     @IBOutlet weak var photoImage: UIImageView!
    
    var models = [News]()
    var news: News!
    
    func configureModels(with models: [News]) {
        self.models = models
        newsCollectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsCollectionView.register(NewsCollectionViewCell.nib(), forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
               newsCollectionView.delegate = self
               newsCollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return models.count // news.photo.count
           }
           
           func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as! NewsCollectionViewCell
            
            //cell.configureNewsImage(for: models[indexPath.row])
            //let photo1 = news.photo[indexPath.row]
            //cell.newsImage.image = photo1
            cell.newsImage.backgroundColor = .red
  
            return cell
           }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
    
    public func configure(for model: News) {
        nameLabel.text = model.name
        dateLabel.text = model.date
        newsLabel.text = model.text
        photoImage.image = model.image
    }
}
