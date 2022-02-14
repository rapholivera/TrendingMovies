//
//  ActionSheetPresentTransitioning.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

final class ActionSheetPresentTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) as? ActionSheetViewController else { return }

        toVC.view.frame = UIScreen.main.bounds
        transitionContext.containerView.addSubview(toVC.view)

        let topView = toVC.topView
        topView.alpha = 0

        let footerView = toVC.footerContainerView
        footerView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.size.height)

        let duration = transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [], animations: {
            topView.alpha = 1
            footerView.transform = .identity

        }, completion: { (finished) in
            transitionContext.completeTransition(finished)
        })
    }
}
