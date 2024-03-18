//
//  MainScreenFactory.swift
//  NewsToDayApp
//
//  Created by Polina on 18.03.2024.
//

import UIKit

enum LabelMainType{
    case headerLabel
    case subHeaderLabel
    case categoryLabel
    case articaleCategoryLabel
    case articleTextLabel
    case recomendedLabel
    case seeAllLabel
    case recommendArticleCategoryLabel
    case recommendArticleTextLabel
}

protocol MainScreenFactoryProtocol{
    func makeLabel(type: LabelMainType) -> UILabel
    func makeImageView() -> UIImageView
}

final class MainScreenFactory: MainScreenFactoryProtocol{
    func makeLabel(type: LabelMainType) -> UILabel {
        switch type{
        case .headerLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Screen.label, lines: 1, alignment: .left, color: ConstColors.blackPrimary)
            return label
        case .subHeaderLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Screen.text, lines: 1, alignment: .left, color: ConstColors.greyPrimary)
            return label
        case .categoryLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Main.tag, lines: 1, alignment: .left, color: ConstColors.customWhite)
            return label
        case .articaleCategoryLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Main.articleCategory, lines: 1, alignment: .left, color: ConstColors.greyLighter)
            return label
        case .articleTextLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Main.articleLabel, lines: 2, alignment: .left, color: ConstColors.customWhite)
            return label
        case .recomendedLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Main.recommendedLabel, lines: 1, alignment: .left, color: ConstColors.blackPrimary)
            return label
        case .seeAllLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Main.seeAllLabel, lines: 1, alignment: .left, color: ConstColors.greyPrimary)
            return label
        case .recommendArticleCategoryLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Main.recommendedArticleCategory, lines: 1, alignment: .left, color: ConstColors.greyPrimary)
            return label
        case .recommendArticleTextLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Main.recommendedArticleLabel, lines: 2, alignment: .left, color: ConstColors.blackPrimary)
            return label
        }
    }
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.configImageView(cornerRadius: 12)
        return imageView
    }
}
