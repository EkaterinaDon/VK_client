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
        backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(for model: SearchResult) {
            
        self.availableGroupName.text = String(model.name)
        guard let url = URL(string: model.photo50) else { return }

        UIImage.loadSearchGroupImage(url: url) { image in
            self.availableGroupPhoto.image = image
        }
        
    }
}

extension UIImage {

    public static func loadSearchGroupImage(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
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
