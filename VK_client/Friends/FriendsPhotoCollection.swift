//
//  FriendsPhotoCollection.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class FriendsPhotoCollection: UIViewController {
    
    @IBOutlet weak var firstImage: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    
    
    var friend: Friend!
    var images = [UIImage]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = friend.name
        
        
        for image in friend.photo {
            images.append(image!)
        }
        
        firstImage.image = images[0]
        
        
        addSwipe()
        
//        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(showFullscreen))
//        self.firstImage.addGestureRecognizer(touchGesture)
        
        firstImage.isUserInteractionEnabled = true
        
    }
    
    
    
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gesture.direction = direction
            self.firstImage.addGestureRecognizer(gesture)   
        }
    }
    
    
    var currentImage = 0
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        
        let direction = gesture.direction
        //let location = gesture.location(in: containerView)
        
        switch direction {
        case .left:
            if currentImage == images.count - 1 {
                currentImage = 0
                
            }else{
                currentImage += 1
            }
            firstImage.image = images[currentImage]
            
            UIView.animate(withDuration: 0.3, animations: {
                let animation = CATransition()
                animation.duration = 1.5
                animation.startProgress = 0.4
                animation.endProgress = 1.0
                animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                animation.type = CATransitionType(rawValue: "pageCurl") // CATransitionType.push
                animation.subtype = CATransitionSubtype.fromRight
                animation.isRemovedOnCompletion = false
                animation.fillMode = CAMediaTimingFillMode(rawValue: "extended") //.both
                animation.isRemovedOnCompletion = false
                animation.autoreverses = true
                
                self.firstImage.layer.add(animation, forKey: "pageFlipAnimation")
                self.containerView.addSubview(self.firstImage)
                self.firstImage.image = self.images[self.currentImage]
            })
            
            
        case .right:
            if currentImage == 0 {
                currentImage = images.count - 1
            }else{
                currentImage -= 1
            }
            firstImage.image = images[currentImage]
            
            UIView.animate(withDuration: 0.3, animations: {
                let animation = CATransition()
                animation.duration = 1.5
                animation.startProgress = 0.4
                animation.endProgress = 1.0 
                animation.type = CATransitionType(rawValue: "pageCurl")
                animation.subtype = CATransitionSubtype.fromLeft
                animation.isRemovedOnCompletion = false
                animation.fillMode = CAMediaTimingFillMode(rawValue: "extended")
                animation.isRemovedOnCompletion = false
                animation.autoreverses = true
                
                self.firstImage.layer.add(animation, forKey: "pageFlipAnimation")
                self.containerView.addSubview(self.firstImage)
                self.firstImage.image = self.images[self.currentImage]
            })

        default:
            break
        }
        
        
        
    }
    
//    @objc func showFullscreen(sender: UITapGestureRecognizer) {
//
//        let imageView = sender.view as! UIImageView
//        imageView.alpha = 0
//        let tmpImageView = UIImageView(image: imageView.image)
//        tmpImageView.frame = self.view.frame
//        tmpImageView.contentMode = UIView.ContentMode.scaleAspectFit
//        tmpImageView.backgroundColor = UIColor.black
//        tmpImageView.isUserInteractionEnabled = true
//
//        let tap = UITapGestureRecognizer(target: self, action: #selector(hideFullscreen))
//        tmpImageView.addGestureRecognizer(tap)
//
//
//        self.view.addSubview(tmpImageView)
//         print("fullscreen")
//    }
//
//    @objc func hideFullscreen(sender: UITapGestureRecognizer) {
//
//
//        sender.view?.removeFromSuperview()
//        print("removed")
//    }
    /*
     MARK: - Navigation
     
     In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     Get the new view controller using segue.destination.
     Pass the selected object to the new view controller.
     }
     */
    
}


