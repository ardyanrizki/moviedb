//
//  UIView+Extension.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//

import UIKit

extension UIView {
    
    func applyGradient(top: UIColor, bottom: UIColor, locationTop: NSNumber = 0.4, locationBottom: NSNumber = 0.8) {
        if let gradientLayer = layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.colors = [top.cgColor, bottom.cgColor]
        } else {
            let gradient = CAGradientLayer()
            gradient.colors = [top.cgColor, bottom.cgColor]
            gradient.locations = [locationTop, locationBottom]
            gradient.frame = self.bounds
            self.layer.insertSublayer(gradient, at: 0)
        }
    }
    
}
