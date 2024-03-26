//
//  TextFieldFactory.swift
//  NewsToDayApp
//
//  Created by Vasilii Pronin on 22.03.2024.
//

import UIKit

final class TextFieldFactory {
    
    static func makeTextField() -> UITextField {
        let textField = BaseTextField()
        textField.layer.cornerRadius = 12
        textField.backgroundColor = UIColor(named: ConstColors.greyLighter)
        return textField
    }
    
    static func makeTextField(
        placeholder: String,
        image: UIImage?
    ) -> UITextField {
        let textField = BaseTextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(
                named: ConstColors.greyPrimary
            )!,
            .font: UIFont.TextFont.Screen.text
        ]
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: attributes
        )
        textField.font = UIFont.TextFont.Screen.text
        
        textField.setIcon(image)
        textField.layer.cornerRadius = 12
        textField.backgroundColor = UIColor(named: ConstColors.greyLighter)
        
        return textField
    }
    
    static func makeSecureTextField(
        placeholder: String,
        image: UIImage?
    ) -> UITextField {
        let textField = BaseTextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(
                named: ConstColors.greyPrimary
            )!,
            .font: UIFont.TextFont.Screen.text
        ]
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: attributes
        )
        textField.font = UIFont.TextFont.Screen.text
        textField.isSecureTextEntry = true
        textField.setIcon(image)
        textField.setSecureInputButton()
        textField.layer.cornerRadius = 12
        textField.backgroundColor = UIColor(named: ConstColors.greyLighter)
        
        return textField
    }
}
