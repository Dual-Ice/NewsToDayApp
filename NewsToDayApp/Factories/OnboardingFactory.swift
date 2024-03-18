//
//  LabelsFactory.swift
//  NewsToDayApp
//
//  Created by Polina on 18.03.2024.
//

import UIKit

enum LabelsOnboardingType{
    case logoLabel
    case headerLAbel
    case textLabel
    case buttonLabel
}

protocol OnboardingFactoryProtocol{
    func makeLabel(type: LabelsOnboardingType) -> UILabel
    func makeImageView() -> UIImageView
}

final class OnboardingFactory: OnboardingFactoryProtocol{
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.configImageView(cornerRadius: 12)
        return imageView
    }
    
    func makeLabel(type: LabelsOnboardingType) -> UILabel {
        switch type{
        case .logoLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Splash.logoLabel, lines: 1, alignment: .left, color: ConstColors.purpleLigher)
            return label
        case .headerLAbel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Screen.label, lines: 1, alignment: .center, color: ConstColors.blackPrimary)
            return label
        case .textLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Screen.text, lines: 0, alignment: .center, color: ConstColors.greyPrimary)
            return label
        case .buttonLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Screen.button, lines: 1, alignment: .center, color: ConstColors.customWhite)
            return label
        }
    }
}
