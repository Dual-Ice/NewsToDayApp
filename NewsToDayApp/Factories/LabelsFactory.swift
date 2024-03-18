//
//  LabelsFactory.swift
//  NewsToDayApp
//
//  Created by Polina on 18.03.2024.
//

import UIKit
protocol LabelsFactoryProtocol{
    func makeLogoLabel() -> UILabel
    func makeHeaderLabel() -> UILabel
    func makeTextLabel() -> UILabel
    func makeButtonLabel() -> UILabel
    func makeCategoryTagLabel() -> UILabel
    func makeArticleHeaderLabel() -> UILabel
    func makeCategoryLabel() -> UILabel
}

final class LabelsFactory: LabelsFactoryProtocol{
    func makeLogoLabel() -> UILabel {
        let label = UILabel()
        label.configLabel(font: UIFont.TextFont.Splash.logoLabel, lines: 1, alignment: .left, color: ConstColors.purpleLigher)
        return label
    }
    
    func makeHeaderLabel() -> UILabel {
        let label = UILabel()
        label.configLabel(font: UIFont.TextFont.Screen.label, lines: 1, alignment: .center, color: ConstColors.blackPrimary)
        return label
    }
    
    func makeTextLabel() -> UILabel {
        let label = UILabel()
        label.configLabel(font: UIFont.TextFont.Screen.text, lines: 0, alignment: .center, color: ConstColors.greyPrimary)
        return label
    }
    
    func makeButtonLabel() -> UILabel{
        let label = UILabel()
        label.configLabel(font: UIFont.TextFont.Screen.button, lines: 1, alignment: .center, color: ConstColors.customWhite)
        return label
    }
    
    func makeCategoryTagLabel() -> UILabel {
        let label = UILabel()
        label.configLabel(font: UIFont.TextFont.Main.tag, lines: 1, alignment: .left, color: ConstColors.customWhite)
        return label
    }
    
    func makeArticleHeaderLabel() -> UILabel{
        let label = UILabel()
        label.configLabel(font: UIFont.TextFont.Main.articleLabel, lines: 2, alignment: .left, color: ConstColors.customWhite)
        return label
    }
    
    func makeCategoryLabel() -> UILabel {
        let label = UILabel()
        label.configLabel(font: UIFont.TextFont.Main.articleCategory, lines: 1, alignment: .left, color: ConstColors.greyLighter)
        return label
    }
}
