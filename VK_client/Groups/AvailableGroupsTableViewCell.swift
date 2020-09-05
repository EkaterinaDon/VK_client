//
//  AvailableGroupsTableViewCell.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class AvailableGroupsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var availableGroupName: UILabel!
    
    @IBOutlet weak var availableGroupPhoto: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(for model: Group) {
        availableGroupName.text = model.name
        availableGroupPhoto.image = UIImage.init(named: model.imageName)
    }
}
