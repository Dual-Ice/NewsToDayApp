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
            .init(emojiString: "💼", categoryName: NSLocalizedString("CategoriesBusiness", comment: "")),
            .init(emojiString: "🩺", categoryName: NSLocalizedString("CategoriesHealth", comment: "")),
            .init(emojiString: "🔬", categoryName: NSLocalizedString("CategoriesScience", comment: "")),
            .init(emojiString: "⚽️", categoryName: NSLocalizedString("CategoriesSports", comment: "")),
            .init(emojiString: "💻", categoryName: NSLocalizedString("CategoriesTechnology", comment: "")),
            .init(emojiString: "🚓", categoryName: NSLocalizedString("CategoriesCrime", comment: "")),
            .init(emojiString: "🎓", categoryName: NSLocalizedString("CategoriesEducation", comment: "")),
            .init(emojiString: "🎬", categoryName: NSLocalizedString("CategoriesEntertainment", comment: "")),
            .init(emojiString: "🌳", categoryName: NSLocalizedString("CategoriesEnvironment", comment: "")),
            .init(emojiString: "🍔", categoryName: NSLocalizedString("CategoriesFood", comment: "")),
            .init(emojiString: "🛋️", categoryName: NSLocalizedString("CategoriesLifestyle", comment: "")),
            .init(emojiString: "🗳️", categoryName: NSLocalizedString("CategoriesPolitics", comment: "")),
        ]
    }
}

