//
//  SearchBarView.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//


import UIKit
import SnapKit

class SearchBarView: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearenceTextField()
        setupAppearenceSeacrhBar()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let color = UIColor(named: ConstColors.greyPrimary)
    private let backColor =  UIColor(named: ConstColors.greyLighter)
  
    private func setupAppearenceTextField(){
        let textField = self.searchTextField
        textField.textColor = color
        textField.backgroundColor = backColor
        textField.font = UIFont.TextFont.Main.searchInput
        textField.layer.cornerRadius = 12.0
        textField.clipsToBounds = true
        
        // Create a custom view for leftView
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24)) // 40 widt + spacing between leftView and search
        if let image = UIImage.Icons.search {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            imageView.tintColor = color
            leftView.addSubview(imageView)
        }
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        // Change color of placeholder text
        let attributedPlaceholder = NSAttributedString(string: NSLocalizedString("MainViewSearchBar", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: color ?? .black])
        textField.attributedPlaceholder = attributedPlaceholder
    }
    
    private func setupAppearenceSeacrhBar(){
        let backgroundImage = UIImage.imageWithColor(color: backColor ?? .white)
        setBackgroundImage(backgroundImage, for: .any, barMetrics: .default)
        layer.cornerRadius = 12.0
        clipsToBounds = true
    }
}

