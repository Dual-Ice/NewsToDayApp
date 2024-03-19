//
//  CategorySectionModel.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//

import Foundation
struct CategorySectionModel{
    let category: [Category]
}
struct Category{
    let title: String
}
extension CategorySectionModel{
    static func getCategories() -> [Category]{
        CategorySectionModel(category: [Category(title: "Business"), Category(title: "Entertainment"), Category(title: "General"), Category(title: "Health"), Category(title: "Science"), Category(title: "Sports"), Category(title: "Technology")]).category
    }
}
