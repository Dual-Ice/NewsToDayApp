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
            .init(image: "", articleCategory: NSLocalizedString("CategoriesBusiness", comment: ""), articleName: ""),
            .init(image: "", articleCategory: NSLocalizedString("CategoriesHealth", comment: ""), articleName: ""),
            .init(image: "", articleCategory: NSLocalizedString("CategoriesScience", comment: ""), articleName: ""),
            .init(image: "", articleCategory: NSLocalizedString("CategoriesSports", comment: ""), articleName: ""),
            .init(image: "", articleCategory: NSLocalizedString("CategoriesTechnology", comment: ""), articleName: ""),
            .init(image: "", articleCategory: NSLocalizedString("CategoriesCrime", comment: ""), articleName: ""),
            .init(image: "", articleCategory: NSLocalizedString("CategoriesEducation", comment: ""), articleName: ""),
            .init(image: "", articleCategory: NSLocalizedString("CategoriesEntertainment", comment: ""), articleName: ""),
            .init(image: "", articleCategory: NSLocalizedString("CategoriesEnvironment", comment: ""), articleName: ""),
            .init(image: "", articleCategory: NSLocalizedString("CategoriesFood", comment: ""), articleName: ""),
            .init(image: "", articleCategory: NSLocalizedString("CategoriesLifestyle", comment: ""), articleName: ""),
            .init(image: "", articleCategory: NSLocalizedString("CategoriesPolitics", comment: ""), articleName: ""),

        ])
    }()
    
    private let corusel: ListSectionModel = {
        .corusel([
            .init(image: "default", articleCategory: "Business", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Entertainment", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "General", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Health", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Science", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Sports", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Technology", articleName: "The latest situation in the presidential election"),
        ])
    }()
    
    private let recomendations: ListSectionModel = {
        .recomendations([
            .init(image: "default", articleCategory: "Business", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Entertainment", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "General", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Health", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Science", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Sports", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Technology", articleName: "The latest situation in the presidential election"),
        ])
    }()
    
    var sectionData: [ListSectionModel]{
        [categories, corusel, recomendations]
    }
}
