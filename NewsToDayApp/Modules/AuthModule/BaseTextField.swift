//
//  BaseTextField.swift
//  NewsToDayApp
//
//  Created by Vasilii Pronin on 22.03.2024.
//

import UIKit

final class BaseTextField: UITextField {
    
    private let inset: CGFloat = 10
    
    private let borderLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(borderLayer)
        borderLayer.isHidden = true
        tintColor = .systemGray2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        makeBorder()
    }
    
    func modify() {
        if isEditing {
            tintColor = UIColor(named: ConstColors.purplePrimary)
            borderLayer.isHidden = false
            backgroundColor = UIColor(named: ConstColors.customWhite)
        } else {
            tintColor = .systemGray2
            borderLayer.isHidden = true
            backgroundColor = UIColor(named: ConstColors.greyLighter)
        }
    }
    
    private func makeBorder() {
        borderLayer.strokeColor = UIColor(
            named: ConstColors.purplePrimary
        )?.cgColor
        borderLayer.lineWidth = 0.5
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
    }
    
    private func setIconForSecureTextField(isEditing: Bool) {
        if isEditing {
//            setIcon(<#T##image: UIImage?##UIImage?#>)
        }
    }
}
