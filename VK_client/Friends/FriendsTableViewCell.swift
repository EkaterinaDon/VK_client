//
//  FriendsTableViewCell.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var friendsName: UILabel!
    
    @IBOutlet var friendsImage: UIImageView!

    
    @IBOutlet weak var avatarView: UIView! {
        didSet {
            self.avatarView.layer.shadowOffset = .init(width: 4, height: 4)
            self.avatarView.layer.shadowOpacity = 0.75
            self.avatarView.layer.shadowRadius = 6
            self.avatarView.backgroundColor = .clear
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        friendsImage.layer.cornerRadius = bounds.height / 2
        friendsImage.layer.masksToBounds = true
        backgroundColor = .clear

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.avatarView.layer.shadowPath = UIBezierPath(ovalIn: self.avatarView.bounds).cgPath
        
    }

}

