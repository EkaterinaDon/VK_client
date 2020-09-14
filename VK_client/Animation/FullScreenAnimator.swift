//
//  FullScreenAnimator.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 14/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class FullScreenAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.8
    var presenting: Bool = true
    var originFrame = CGRect.zero
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let destination = transitionContext.view(forKey: .to)!
        
        let fullScreenImage = presenting ? destination : transitionContext.view(forKey: .from)! 
        
        let initialFrame = presenting ? originFrame : fullScreenImage.frame
        let finalFrame = presenting ? fullScreenImage.frame : originFrame
        
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            fullScreenImage.transform = scaleTransform
            fullScreenImage.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            fullScreenImage.clipsToBounds = true
        }
        
        fullScreenImage.layer.cornerRadius = presenting ? 20.0 : 0.0
        fullScreenImage.layer.masksToBounds = true
        
        containerView.addSubview(destination)
        containerView.bringSubviewToFront(fullScreenImage)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, animations: {
            fullScreenImage.transform = self.presenting ? .identity : scaleTransform
            fullScreenImage.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            fullScreenImage.layer.cornerRadius = !self.presenting ? 20.0 : 0.0
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
        
        
    }
    
    
}
