//
//  NewsCollectionViewCell.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 31/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var newsImage: UIImageView!
    
    static let identifier = "NewsCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NewsCollectionViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
