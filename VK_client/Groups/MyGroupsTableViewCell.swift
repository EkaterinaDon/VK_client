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
    
    func configure(for model: Group) {
        self.myGroupName.text = model.name
        guard let url = URL(string: model.photo) else { return }
        
        UIImage.loadGroupImage(url: url) { image in
            self.myGroupPhoto.image = image
        }
        
    }
    
}

extension UIImage {
    
    public static func loadGroupImage(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
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
