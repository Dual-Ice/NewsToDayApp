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
}
