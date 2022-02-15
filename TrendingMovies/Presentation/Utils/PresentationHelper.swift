//
//  PresentationHelper.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class PresentationHelper {

    static private var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
        // Keep only active scenes, onscreen and visible to the user
        .filter { $0.activationState == .foregroundActive }
        // Keep only the first `UIWindowScene`
        .first(where: { $0 is UIWindowScene })
        // Get its associated windows
        .flatMap({ $0 as? UIWindowScene })?.windows
        // Finally, keep only the key window
        .first(where: \.isKeyWindow)
    }

    static func topViewController(base: UIViewController? = keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }

        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }

        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }

        return base
    }

    static func romePresentedModalsViewControllers() {
        if let topController = topViewController() {
            if !topController.isKind(of: ContainerViewController.self) {
                topController.dismiss(animated: true, completion: nil)
            }
        }
    }

    static func getImageWithInvertedPixelsOfImage(image: UIImage) -> UIImage {
        let rect = CGRect(origin: CGPoint(), size: image.size)

        UIGraphicsBeginImageContextWithOptions(image.size, false, 2.0)
        UIGraphicsGetCurrentContext()!.setBlendMode(.copy)
        image.draw(in: rect)
        UIGraphicsGetCurrentContext()!.setBlendMode(.sourceOut)
        UIGraphicsGetCurrentContext()!.fill(rect)

        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }

    static var iPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    static func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
