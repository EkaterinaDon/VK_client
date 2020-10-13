//
//  MyGroupsTableViewCell.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class MyGroupsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myGroupName: UILabel!
    @IBOutlet weak var myGroupPhoto: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myGroupPhoto.layer.cornerRadius = bounds.height / 2
        myGroupPhoto.layer.masksToBounds = true
        backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
//    func configure(for model: Group) {
//        myGroupName.text = model.name
//        myGroupPhoto.image = UIImage.init(named: model.imageName)
//
//    }
    func configure(for model: Group) {
        self.myGroupName.text = model.name
        //self.friendsImage.image = UIImage(named: model.photo)
        
        }
    
}
