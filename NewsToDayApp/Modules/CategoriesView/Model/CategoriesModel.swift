//
//  CategoriesViewModel.swift
//  NewsToDayApp
//
//  Created by Polina on 22.03.2024.
//

import Foundation
struct CategoriesModel {
    var emojiString: String
    var categoryName: String
}

extension CategoriesModel{
    static func getAllCategories()  -> [CategoriesModel]{
        [
            .init(emojiString: "⚽️", categoryName: "Business"),
            .init(emojiString: "⚽️", categoryName: "Entertainment"),
            .init(emojiString: "⚽️", categoryName: "General"),
            .init(emojiString: "⚽️", categoryName: "Health"),
            .init(emojiString: "⚽️", categoryName: "Science"),
            .init(emojiString: "⚽️", categoryName: "Sports"),
            .init(emojiString: "⚽️", categoryName: "Technology"),
        ]
    }
}
