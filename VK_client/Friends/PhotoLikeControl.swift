//
//  PhotoLikeControl.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 11/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class PhotoLike: UIStackView {
    
    var counter = 0
    let count = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCounter()
        setupButton()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupCounter()
        setupButton()
    }
    
    private func setupCounter() {
        
        count.backgroundColor = UIColor.clear
        count.textColor = UIColor.blue
        count.text = "\(counter)"
        removeArrangedSubview(count)
        count.removeFromSuperview()
        
        count.translatesAutoresizingMaskIntoConstraints = false
        count.heightAnchor.constraint(equalToConstant: labelSize.height).isActive = true
        count.widthAnchor.constraint(equalToConstant: labelSize.width).isActive = true
        
        addArrangedSubview(count)
        
    }
    
    private func setupButton() {
        
        
        let heartButton = UIButton()
        
        removeArrangedSubview(heartButton)
        heartButton.removeFromSuperview()
        
        let bundle = Bundle(for: type(of: self))
        let filledHeart = UIImage(named: "filledHeart", in: bundle, compatibleWith: self.traitCollection)
        let emptyHeart = UIImage(named: "heart", in: bundle, compatibleWith: self.traitCollection)
        
        
        heartButton.setImage(emptyHeart, for: .normal)
        heartButton.setImage(filledHeart, for: .selected)
        
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        heartButton.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
        heartButton.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
        
        addArrangedSubview(heartButton)
        //button action
        heartButton.addTarget(self, action: #selector(PhotoLike.heartButtonTupped(heartButton:)), for: .touchUpInside)
        
        
    }
    
    //MARK: Button Action
    @objc func heartButtonTupped(heartButton: UIButton) {
        
        if heartButton.isSelected == true {
            heartButton.isSelected = false
            counter -= 1
            count.textColor = UIColor.blue
            UIView.animate(withDuration: 0.5, animations: {
                UIView.modifyAnimations(withRepeatCount: 3, autoreverses: true, animations: {
                    self.count.frame.origin.y -= 15
                })
                
            }, completion: { finished in
                print("dislike!")
                self.count.alpha = 1
            })
        } else {
            heartButton.isSelected = true
            counter += 1
            count.textColor = UIColor.red
            UIView.animate(withDuration: 0.5, animations: {
                UIView.modifyAnimations(withRepeatCount: 3, autoreverses: true, animations: {
                    self.count.frame.origin.y += 15
                })
            }, completion: { finished in
                print("like!")
                self.count.alpha = 1
            })
        }
        //        print("pressed \(counter)")
        count.text = "\(counter)"
        
    }
    
    
    
    
    
    var labelSize: CGSize = CGSize(width: 25.0, height: 24.0) {
        didSet {
            setupCounter()
        }
    }
    
    var buttonSize: CGSize = CGSize(width: 25.0, height: 24.0) {
        didSet {
            setupButton()
        }
    }
    
    
    
}



