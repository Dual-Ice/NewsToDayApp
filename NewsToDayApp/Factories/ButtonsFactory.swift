//
//  ButtonsFactory.swift
//  NewsToDayApp
//
//  Created by Polina on 18.03.2024.
//

import UIKit



final class ButtonsFactory{
    static func makeButton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: ConstColors.purplePrimary)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
