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
    
    func configBackImageView(backColor: String, borderWidth: CGFloat, borderColor: String){
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor(named: borderColor)?.cgColor
        self.backgroundColor = UIColor(named: backColor)
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configSfSymbolImageView(image: UIImage, color: String){
        self.image = image
        self.tintColor = UIColor(named: color)
        self.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
