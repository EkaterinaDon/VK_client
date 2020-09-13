//
//  NavigationAnimation.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 09/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit


class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            self.interactiveTransition.viewController = toVC
            return CustomPushAnimator()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return CustomPopAnimator()
        }
        
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    
}


class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    
    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgeGesture(_:)))
            recognizer.edges = [.left]
            //viewController?.view.addGestureRecognizer(recognizer)
            viewController?.navigationController?.view.addGestureRecognizer(recognizer)
        }
    }
    
    
    var hasStarted: Bool = false
    var shouldFinish: Bool = false
    
    @objc func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self.hasStarted = true
            self.viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            
            self.shouldFinish = progress > 0.33
            
            self.update(progress)
        case .ended:
            self.hasStarted = false
            self.shouldFinish ? self.finish() : self.cancel()
        case .cancelled:
            self.hasStarted = false
            self.cancel()
        default: return
        }
    }
    
    
    
}


final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        
                let container = transitionContext.containerView
                container.addSubview(destination.view)
        
        
                let rotateIn = CGAffineTransform(rotationAngle: 180)
                let rotateOut = CGAffineTransform(rotationAngle: -180)
        
               
                destination.view.transform = rotateIn
        
        
                source.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
                destination.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        
        
                source.view.layer.position = CGPoint(x: 0, y: 0)
                destination.view.layer.position = CGPoint(x: 0, y: 0)
        
        
                container.addSubview(source.view)
                container.addSubview(destination.view)
        
                UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                        delay: 0,
                                        options: .calculationModePaced,
                                        animations: {
                                            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {
                                                source.view.transform = rotateOut
        
                                            })
        
                                            UIView.addKeyframe(withRelativeStartTime: 0.6,
                                                               relativeDuration: 0.4,
                                                               animations: {
                                                                destination.view.transform = rotateIn
        
                                                                destination.view.transform = .identity
        
        
                                            })
                }) { finished in
                    if finished && !transitionContext.transitionWasCancelled {
                        destination.view.transform = .identity
                    }
                    transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
                }
        
    }
    
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2 //0.6
    }
    
    
    
}



final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        2//0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
                transitionContext.containerView.addSubview(destination.view)
                transitionContext.containerView.sendSubviewToBack(destination.view)
        
                let container = transitionContext.containerView
                container.addSubview(destination.view)
        
        
                let rotateIn = CGAffineTransform(rotationAngle: -180)
                let rotateOut = CGAffineTransform(rotationAngle: 180)
        
        
        
        
                destination.view.transform = rotateIn
        
                source.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
                destination.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        
                source.view.layer.position = CGPoint(x: 0, y: 0)
                destination.view.layer.position = CGPoint(x: 0, y: 0)
        
                container.addSubview(source.view)
                container.addSubview(destination.view)
        
                UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                        delay: 0,
                                        options: .calculationModePaced,
                                        animations: {
                                            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {
                                                source.view.transform = rotateOut
        
                                            })
        
                                            UIView.addKeyframe(withRelativeStartTime: 0.6,
                                                               relativeDuration: 0.4,
                                                               animations: {
                                                                destination.view.transform = rotateIn
        
                                                                destination.view.transform = .identity
        
        
                                            })
                }) { finished in
                    if finished && !transitionContext.transitionWasCancelled {
                        destination.view.transform = .identity
                    }
                    transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
                }
    }
}

extension UIView {

    func setAnchorPoint(anchorPoint: CGPoint, view: UIView) {
        var newPoint: CGPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
        var oldPoint: CGPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)

        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)

        var position: CGPoint = view.layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y


        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.anchorPoint = anchorPoint
        view.layer.position = position
    }
    
}


