//
//  TermsConditionsFactory.swift
//  NewsToDayApp
//
//  Created by Polina on 18.03.2024.
//

import UIKit

enum LabelsTermsConditionsType{
    case headerLabel
    case textLabel
}

protocol TermsConditionsFactoryProtocol{
    func makeLabel(type: LabelsTermsConditionsType) -> UILabel
}

final class TermsConditionsFactory: TermsConditionsFactoryProtocol{
    func makeLabel(type: LabelsTermsConditionsType) -> UILabel {
        switch type{
        case .headerLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Screen.label, lines: 1, alignment: .center, color: ConstColors.blackPrimary)
            return label
        case .textLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.TermsAndConditions.text, lines: 0, alignment: .left, color: ConstColors.greyPrimary)
            return label
        }
    }
}
