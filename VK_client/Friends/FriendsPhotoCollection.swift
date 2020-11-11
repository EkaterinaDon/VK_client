//
//  FriendsPhotoCollection.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit
import RealmSwift

class FriendsPhotoCollection: UIViewController {
    
    @IBOutlet weak var firstImage: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func collectionButtonDidPressed(_ sender: Any) {
        let friendsCollectionViewController = self.storyboard?.instantiateViewController(withIdentifier: "FriendsCollectionViewController") as! FriendsCollectionViewController
        friendsCollectionViewController.friend = friend
        self.navigationController!.pushViewController(friendsCollectionViewController, animated: true)
    }
    
    @IBOutlet weak var collectionButton: UIButton!
    
    var friendsService = FriendsService()
    var friendsPhotos = [Item]()
    
    var friend: FriendFireStore! //Friend!
    var images = [UIImage]()
    
    let transition = FullScreenAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        friendsService.getPhoto(owner_id: "\(friend.id)") { [weak self] friendsPhotos in
            self?.friendsPhotos = friendsPhotos
            
            debugPrint(friendsPhotos)
        }
        
        title = friend.first_name + friend.last_name
        
        
//        for image in friend.photo {
//            images.append(image!)
//        }
        
       // firstImage.image = images[0]
        
        
        addSwipe()
        firstImage.isUserInteractionEnabled = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showFullScreen))
        tapRecognizer.numberOfTapsRequired = 2
        self.firstImage.addGestureRecognizer(tapRecognizer)
        
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
    
    @objc func showFullScreen(sender: UITapGestureRecognizer) {
        let fullScreenPhotoViewController = storyboard?.instantiateViewController(withIdentifier: "FullScreenPhotoViewController") as! FullScreenPhotoViewController
        fullScreenPhotoViewController.imageToShow = firstImage.image
        self.present(fullScreenPhotoViewController, animated: true, completion: nil)
        
    }
    
}

extension FriendsPhotoCollection: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.originFrame = firstImage.frame
        transition.originFrame = CGRect(x: transition.originFrame.origin.x + 20, y: transition.originFrame.origin.y + 20, width: transition.originFrame.size.width - 40, height: transition.originFrame.size.height - 40)
        
        transition.presenting = true
        firstImage.isHidden = true
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
    
}

extension UIImage {

    public static func loadFriendsPhotos(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
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
