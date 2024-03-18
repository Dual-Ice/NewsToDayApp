//
//  ArticleFactory.swift
//  NewsToDayApp
//
//  Created by Polina on 18.03.2024.
//

import UIKit

enum LabelArticleType{
    case categoryLabel
    case articleNameLabel
    case authorNameLabel
    case authorLabel
    case articleHeaderLabel
    case articleTextlabel
}

protocol ArticleFactoryProtocol{
    func makeLabel(type: LabelArticleType) -> UILabel
    func makeImageView() -> UIImageView
}

final class ArticleFactory: ArticleFactoryProtocol{
    func makeLabel(type: LabelArticleType) -> UILabel {
        switch type{
        case .categoryLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Article.tag, lines: 1, alignment: .left, color: ConstColors.customWhite)
            return label
        case .articleNameLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Article.label, lines: 0, alignment: .left, color: ConstColors.customWhite)
            return label
        case .authorNameLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Article.authorName, lines: 1, alignment: .left, color: ConstColors.customWhite)
            return label
        case .authorLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Article.authorLabel, lines: 1, alignment: .left, color: ConstColors.greyLight)
            return label
        case .articleHeaderLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Article.articleLabel, lines: 1, alignment: .left, color: ConstColors.blackPrimary)
            return label
        case .articleTextlabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Article.articleText, lines: 1, alignment: .left, color: ConstColors.greyDarker)
            return label
        }
    }
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.configImageView(cornerRadius: 0)
        return imageView
    }
}
