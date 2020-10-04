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

    
    @IBOutlet weak var avatarView: UIView! { //AvatarView! 
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
        // Initialization code
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.avatarView.layer.shadowPath = UIBezierPath(ovalIn: self.avatarView.bounds).cgPath
        
    }

 
    
//    func configure(for model: Friend) {
//        friendsName.text = model.name
//        friendsImage.image = model.image
//    }

    func configure(for model: Friend) {
            
        self.friendsName.text = String(model.firstName + model.lastName)
        //self.friendsImage.image = UIImage(named: model.photo)
        
        }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
