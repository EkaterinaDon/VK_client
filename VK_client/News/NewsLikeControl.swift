//
//  NewsLikeControl.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 31/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class NewsLike: UIStackView {
    
    var counter = 0
    let count = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCounter()
        setupLikeButton()
        setupCommentButton()
        setupShareButton()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupCounter()
        setupLikeButton()
        setupCommentButton()
        setupShareButton()
    }
    
    private func setupCounter() {
        
        count.backgroundColor = UIColor.clear
        count.textColor = UIColor.blue
        count.text = "\(counter)"
        count.textAlignment = .right
        removeArrangedSubview(count)
        count.removeFromSuperview()
        
        count.translatesAutoresizingMaskIntoConstraints = false
        count.heightAnchor.constraint(equalToConstant: labelSize.height).isActive = true
        count.widthAnchor.constraint(equalToConstant: labelSize.width).isActive = true
        
        addArrangedSubview(count)
        
    }
    
    private func setupLikeButton() {
        
        
        let heartButton = UIButton()
        
        removeArrangedSubview(heartButton)
        heartButton.removeFromSuperview()
        
        let bundle = Bundle(for: type(of: self))
        let filledHeart = UIImage(named: "filledHeart_clear", in: bundle, compatibleWith: self.traitCollection)
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
    
    private func setupCommentButton() {
        
        
        let commentButton = UIButton()
        
        removeArrangedSubview(commentButton)
        commentButton.removeFromSuperview()
        
        let bundle = Bundle(for: type(of: self))
        let comment = UIImage(named: "commentButton", in: bundle, compatibleWith: self.traitCollection)
        //let emptyHeart = UIImage(named: "emptyHeart", in: bundle, compatibleWith: self.traitCollection)
        
        
        //commentButton.setImage(emptyHeart, for: .selected)
        commentButton.setImage(comment, for: .normal)
        
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        commentButton.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
        commentButton.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
        
        addArrangedSubview(commentButton)
        //button action
        commentButton.addTarget(self, action: #selector(NewsLike.commentButtonTupped(commentButton:)), for: .touchUpInside)
        
        
    }
    
    private func setupShareButton() {
        
        
        let shareButton = UIButton()
        
        removeArrangedSubview(shareButton)
        shareButton.removeFromSuperview()
        
        let bundle = Bundle(for: type(of: self))
        let share = UIImage(named: "shareButton", in: bundle, compatibleWith: self.traitCollection)
        //let emptyHeart = UIImage(named: "emptyHeart", in: bundle, compatibleWith: self.traitCollection)
        
        
        //commentButton.setImage(emptyHeart, for: .selected)
        shareButton.setImage(share, for: .normal)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
        
        addArrangedSubview(shareButton)
        //button action
        shareButton.addTarget(self, action: #selector(NewsLike.shareButtonTupped(shareButton:)), for: .touchUpInside)
        
        
    }
    //MARK: Button Action
    @objc func heartButtonTupped(heartButton: UIButton) {
        
        if heartButton.isSelected == true {
            heartButton.isSelected = false
            counter -= 1
            count.textColor = UIColor.blue
        } else {
            heartButton.isSelected = true
            counter += 1
            count.textColor = UIColor.red
        }
        //        print("pressed \(counter)")
        count.text = "\(counter)"
    }
    
    @objc func commentButtonTupped(commentButton: UIButton) {
        print("commentButton Clicked")
    }
    
    @objc func shareButtonTupped(shareButton: UIButton) {
        print("shareButton Clicked")
    }
    
    var labelSize: CGSize = CGSize(width: 25.0, height: 24.0) {
        didSet {
            setupCounter()
        }
    }
    
    var buttonSize: CGSize = CGSize(width: 25.0, height: 24.0) {
        didSet {
            setupLikeButton()
        }
    }
    
    
    
}


