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

    func configure(for model: FriendFireStore) {
            
        self.friendsName.text = model.name
        guard let url = URL(string: model.photo) else { return }

        UIImage.loadFriendsImage(url: url) { image in
            self.friendsImage.image = image
        }
        
        }
}


extension UIImage {

    public static func loadFriendsImage(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
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
