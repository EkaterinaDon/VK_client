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
    
    @IBOutlet weak var friendsImage: UIImageView!
    
    @IBOutlet weak var avatarView: AvatarView!
    

    @IBOutlet weak var gradientView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        friendsImage.layer.cornerRadius = bounds.height / 2
        backgroundColor = .clear
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(for model: Friend) {
        friendsName.text = model.name
        friendsImage.image = model.image        
    }

  
}

