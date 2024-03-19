//
//  UIImageView + ext.swift
//  NewsToDayApp
//
//  Created by Polina on 18.03.2024.
//

import UIKit
extension UIImageView {
    func configImageView(cornerRadius: CGFloat){
        self.layer.cornerRadius = cornerRadius
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyGradientMask(colors: [UIColor], locations: [NSNumber]?) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.backgroundColor = UIColor.black.withAlphaComponent(0.1).cgColor
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        layer.addSublayer(gradientLayer)
    }
}
