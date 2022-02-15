//
//  UIButton+Gradient.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

extension UIView {
  func applyGradient(colors: [UIColor]) {
    clipsToBounds = true
    let gradient = CAGradientLayer()
    gradient.frame = self.bounds
    gradient.colors = colors.map { $0.cgColor }
    gradient.startPoint = CGPoint(x: 0, y: 0)
    gradient.endPoint = CGPoint(x: 0, y: 1)
    gradient.isHidden = false

    self.layer.insertSublayer(gradient, at: 0)
  }
}
