//
//  CategoriesViewModel.swift
//  NewsToDayApp
//
//  Created by Polina on 22.03.2024.
//

import Foundation
struct CategoriesModel {
    let emojiString: String
    let categoryNameLabel: String
    let categoryNameValue: String
}

extension CategoriesModel{
    static func getAllCategories()  -> [CategoriesModel]{
        [
            .init(emojiString: "💼", categoryNameLabel: NSLocalizedString("CategoriesBusiness", comment: ""), categoryNameValue: "business"),
            .init(emojiString: "🩺", categoryNameLabel: NSLocalizedString("CategoriesHealth", comment: ""), categoryNameValue: "health"),
            .init(emojiString: "🔬", categoryNameLabel: NSLocalizedString("CategoriesScience", comment: ""), categoryNameValue: "science"),
            .init(emojiString: "⚽️", categoryNameLabel: NSLocalizedString("CategoriesSports", comment: ""), categoryNameValue: "sports"),
            .init(emojiString: "💻", categoryNameLabel: NSLocalizedString("CategoriesTechnology", comment: ""), categoryNameValue: "technology"),
            .init(emojiString: "🚓", categoryNameLabel: NSLocalizedString("CategoriesCrime", comment: ""), categoryNameValue: "crime"),
            .init(emojiString: "🎓", categoryNameLabel: NSLocalizedString("CategoriesEducation", comment: ""), categoryNameValue: "education"),
            .init(emojiString: "🎬", categoryNameLabel: NSLocalizedString("CategoriesEntertainment", comment: ""), categoryNameValue: "entertainment"),
            .init(emojiString: "🌳", categoryNameLabel: NSLocalizedString("CategoriesEnvironment", comment: ""), categoryNameValue: "environment"),
            .init(emojiString: "🍔", categoryNameLabel: NSLocalizedString("CategoriesFood", comment: ""), categoryNameValue: "food"),
            .init(emojiString: "🛋️", categoryNameLabel: NSLocalizedString("CategoriesLifestyle", comment: ""), categoryNameValue: "lifestyle"),
            .init(emojiString: "🗳️", categoryNameLabel: NSLocalizedString("CategoriesPolitics", comment: ""), categoryNameValue: "politics"),
        ]
    }
}

