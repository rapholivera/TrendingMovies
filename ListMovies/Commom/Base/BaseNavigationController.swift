//
//  BaseNavigationController.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class BaseNavigationController: UINavigationController {

   override func viewDidLoad() {
      super.viewDidLoad()
      transparentNavigation()
      replaceBackButton()
   }

   override var preferredStatusBarStyle: UIStatusBarStyle {
      if let visibleVC = visibleViewController {
         return visibleVC.preferredStatusBarStyle
      }
      return super.preferredStatusBarStyle
   }

   override open var shouldAutorotate: Bool {
      if let visibleVC = visibleViewController {
         return visibleVC.shouldAutorotate
      }
      return super.shouldAutorotate
   }

   override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
      if let visibleVC = visibleViewController {
         return visibleVC.preferredInterfaceOrientationForPresentation
      }
      return super.preferredInterfaceOrientationForPresentation
   }

   override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      if let visibleVC = visibleViewController {
         return visibleVC.supportedInterfaceOrientations
      }
      return super.supportedInterfaceOrientations
   }

   open func pushViewControllerFromRoot(_ viewController: UIViewController) {
      self.setViewControllers([self.viewControllers[0], viewController], animated: true)
   }

   private func transparentNavigation() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .white
        navigationBar.isTranslucent = true
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = .clear
   }

   private func replaceBackButton() {
      navigationBar.tintColor = .white
      navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left")
      navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
   }
}
