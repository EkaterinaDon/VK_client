//
//  FullScreenPhotoViewController.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 13/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class FullScreenPhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    var imageToShow : UIImage?
    
    var friend: Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = imageToShow
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        UIView.animate(withDuration: 0.2) {
            self.dismissButton.alpha = 0
        }
    }
    
    
    @IBAction func dismissButtonDidPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}
