//
//  ActionSheetDimissTransitioning.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

final class ActionSheetDimissTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? ActionSheetViewController else { return }

        let topView = fromVC.topView
        let footerView = fromVC.footerContainerView
        let duration = transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration, animations: {
            topView.alpha = 0
            footerView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.size.height)
        }, completion: { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
