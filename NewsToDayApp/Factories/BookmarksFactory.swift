//
//  BookmarksFactory.swift
//  NewsToDayApp
//
//  Created by Polina on 18.03.2024.
//

import UIKit

enum LabelBooksmarksType{
    case headerLabel
    case subHeaderLabel
    case articleCategoryLabel
    case articleTextlabel
    case emptyLabel
}

enum ImageBooksmarksType{
    case articleImage
    case emptyImageBackGround
    case sfSymbolImage
}

protocol BookmarksFactoryProtocol{
    func makeLabel(type: LabelBooksmarksType) -> UILabel
    func makeImageView(type: ImageBooksmarksType) -> UIImageView
}

final class BookmarksFactory: BookmarksFactoryProtocol{
    func makeImageView(type: ImageBooksmarksType) -> UIImageView {
        switch type{
        case .articleImage:
            let imageView = UIImageView()
            imageView.configImageView(cornerRadius: 12)
            return imageView
        case .emptyImageBackGround:
            let imageView = UIImageView()
            imageView.configBackImageView(backColor: ConstColors.greyLight, borderWidth: 0.5, borderColor: ConstColors.blackPrimary)
            return imageView
        case .sfSymbolImage:
            let imageView = UIImageView()
            imageView.configSfSymbolImageView(image: UIImage(named: "book-alt")!, color: ConstColors.purplePrimary)
            return imageView
        }
    }
    
    func makeLabel(type: LabelBooksmarksType) -> UILabel {
        switch type{
        case .headerLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Screen.label, lines: 1, alignment: .left, color: ConstColors.blackPrimary)
            return label
        case .subHeaderLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Screen.text, lines: 1, alignment: .left, color: ConstColors.greyPrimary)
            return label
        case .articleCategoryLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Bookmarks.articleCategory, lines: 1, alignment: .left, color: ConstColors.greyPrimary)
            return label
        case .articleTextlabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Bookmarks.articleLabel, lines: 2, alignment: .left, color: ConstColors.blackPrimary)
            return label
        case .emptyLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Bookmarks.emptyText, lines: 0, alignment: .center, color: ConstColors.blackPrimary)
            return label
        }
    }
}
