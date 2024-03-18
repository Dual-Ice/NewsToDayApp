//
//  Labels + ext.swift
//  NewsToDayApp
//
//  Created by Polina on 18.03.2024.
//

import UIKit
extension UILabel {
    func configLabel(font: UIFont, lines: Int, alignment: NSTextAlignment, color: String) {
        self.textAlignment = alignment
        self.textColor = UIColor(named: color)
        self.numberOfLines = lines
        self.font = font
        self.lineBreakMode = .byTruncatingTail
        self.sizeToFit()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
