//
//  MockData.swift
//  NewsToDayApp
//
//  Created by Polina on 22.03.2024.
//

import Foundation

struct MockData{
    
    private let categories: ListSectionModel = {
        .categories([
            .init(image: "", articleCategoryLabel: NSLocalizedString("CategoriesBusiness", comment: ""), articleName: "", articleCategoryValue: "Business"),
            .init(image: "", articleCategoryLabel: NSLocalizedString("CategoriesHealth", comment: ""), articleName: "", articleCategoryValue: "Health"),
            .init(image: "", articleCategoryLabel: NSLocalizedString("CategoriesScience", comment: ""), articleName: "", articleCategoryValue: "Science"),
            .init(image: "", articleCategoryLabel: NSLocalizedString("CategoriesSports", comment: ""), articleName: "", articleCategoryValue: "Sports"),
            .init(image: "", articleCategoryLabel: NSLocalizedString("CategoriesTechnology", comment: ""), articleName: "", articleCategoryValue: "Technology"),
            .init(image: "", articleCategoryLabel: NSLocalizedString("CategoriesCrime", comment: ""), articleName: "", articleCategoryValue: "Crime"),
            .init(image: "", articleCategoryLabel: NSLocalizedString("CategoriesEducation", comment: ""), articleName: "", articleCategoryValue: "Education"),
            .init(image: "", articleCategoryLabel: NSLocalizedString("CategoriesEntertainment", comment: ""), articleName: "", articleCategoryValue: "Entertainment"),
            .init(image: "", articleCategoryLabel: NSLocalizedString("CategoriesEnvironment", comment: ""), articleName: "", articleCategoryValue: "Environment"),
            .init(image: "", articleCategoryLabel: NSLocalizedString("CategoriesFood", comment: ""), articleName: "", articleCategoryValue: "Food"),
            .init(image: "", articleCategoryLabel: NSLocalizedString("CategoriesLifestyle", comment: ""), articleName: "", articleCategoryValue: "Lifestyle"),
            .init(image: "", articleCategoryLabel: NSLocalizedString("CategoriesPolitics", comment: ""), articleName: "", articleCategoryValue: "Politics"),

        ])
    }()
    
    private let corusel: ListSectionModel = {
        .corusel([
            .init(image: "default", articleCategoryLabel: "Business", articleName: "The latest situation in the presidential election", articleCategoryValue: "Business"),
          
        ])
    }()
    
    private let recomendations: ListSectionModel = {
        .recomendations([
            .init(image: "default", articleCategoryLabel: "Business", articleName: "The latest situation in the presidential election", articleCategoryValue: "Business"),
        ])
    }()
    
    var sectionData: [ListSectionModel]{
        [categories, corusel, recomendations]
    }
}
