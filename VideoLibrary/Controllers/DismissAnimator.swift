//
//  DismissAnimator.swift
//  VideoLibrary
//
//  Created by Manish Kumar on 01/12/21.
//

import Foundation
import UIKit

class DismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //1) setup the transition
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        //2) animations!
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [], animations: {
            
            fromView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }, completion: {_ in
            
            //3) complete the transition
            transitionContext.completeTransition(
                !transitionContext.transitionWasCancelled
            )
        })
        
        
    }
    
}
