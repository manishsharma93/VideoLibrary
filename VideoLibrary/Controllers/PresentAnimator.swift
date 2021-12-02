//
//  PresentAnimator.swift
//  VideoLibrary
//
//  Created by Manish Kumar on 01/12/21.
//

import Foundation
import UIKit

class PresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.5
    
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        
        //2) create animation
        let finalFrame = toView.frame
        
        let xScaleFactor = originFrame.width / finalFrame.width
        let yScaleFactor = originFrame.height / finalFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        toView.transform = scaleTransform
        toView.center = CGPoint(
            x: originFrame.midX,
            y: originFrame.midY
        )
        
        toView.clipsToBounds = true
        
        
        
        containerView.addSubview(toView)
        
        
        UIView.animate(withDuration: duration, delay: 0.0,
                       options: [], animations: {
            
            toView.transform = CGAffineTransform.identity
            toView.center = CGPoint(
                x: finalFrame.midX,
                y: finalFrame.midY
            )
            
        }, completion: {_ in
            
            //3 complete the transition
            transitionContext.completeTransition(
                !transitionContext.transitionWasCancelled
            )
        })
        
    }
    
}
