//
//  AuthFactory.swift
//  NewsToDayApp
//
//  Created by Polina on 18.03.2024.
//

import UIKit

enum LabelsAuthFactoryType{
    case headerLabel
    case textLabel
    case buttonLabele
}

protocol AuthFactoryProtocol{
    func makeLabel(type: LabelsAuthFactoryType) -> UILabel
}

final class AuthFactory: AuthFactoryProtocol{
    func makeLabel(type: LabelsAuthFactoryType) -> UILabel {
        switch type{
        case .headerLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Screen.label, lines: 1, alignment: .center, color: ConstColors.blackPrimary)
            return label
        case .textLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Screen.text, lines: 0, alignment: .center, color: ConstColors.greyPrimary)
            return label
        case .buttonLabele:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Screen.button, lines: 1, alignment: .center, color: ConstColors.customWhite)
            return label
        }
    }
}
