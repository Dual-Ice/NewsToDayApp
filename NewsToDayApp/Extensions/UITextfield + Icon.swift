//
//  UITextfield + Icon.swift
//  NewsToDayApp
//
//  Created by Vasilii Pronin on 25.03.2024.
//

import UIKit

extension UITextField {
    
    func setIcon(_ image: UIImage?) {
        if leftView != nil {
            leftView = nil
        }
        
        let imageView = UIImageView(frame: CGRect(x: 16, y: 10, width: 20, height: 20))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        imageContainerView.addSubview(imageView)
        leftView = imageContainerView
        leftViewMode = .always
    }
    
    func setSecureInputButton() {
        let button = UIButton(type: .custom)
        let image = UIImage.Icons.secureInput
        let action = UIAction { [weak self] action in
            self?.isSecureTextEntry.toggle()
        }
        button.frame = CGRect(x: 16, y: 10, width: 20, height: 20)
        button.setImage(image, for: .normal)
        button.addAction(action, for: .touchUpInside)
        button.sizeToFit()
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        containerView.addSubview(button)
        rightView = containerView
        rightViewMode = .whileEditing
    }
}
