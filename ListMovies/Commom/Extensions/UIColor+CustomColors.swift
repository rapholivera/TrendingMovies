//
//  UIColor+CustomColors.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

extension UIColor {

    public static var backgroundPrimaryColor: UIColor {
        return UIColor(rgba: "#1b1c28")
    }
    public static var backgroundSecundaryColor: UIColor {
        return UIColor(rgba: "#222332")
    }
    public static func blackWith(alpha: CGFloat) -> UIColor {
        return UIColor(white: 0, alpha: alpha)
    }
    public static var errorRed: UIColor {
        return UIColor(rgba: "#f15153")
    }
    public static var buttonGradientPrimaryColor: UIColor {
        return UIColor(rgba: "#582cff")
    }
    public static var buttonGradientSecundaryColor: UIColor {
        return UIColor(rgba: "#8452f2")
    }
    public static var buttonGradientPrimaryColorStyle2: UIColor {
        return UIColor(rgba: "#6074e4")
    }
    public static var buttonGradientSecundaryColorStyle2: UIColor {
        return UIColor(rgba: "#9362e4")
    }
}
