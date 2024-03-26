//
//  CoruselSectionModel.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//


import Foundation

struct MockItem: Hashable{
    let image: String
    let articleCategoryLabel: String
    let articleName: String
    let articleCategoryValue: String
}

extension MockItem{
    static func  getArticleModel() -> [MockItem]{
        [
            .init(image: "default", articleCategoryLabel: "Business", articleName: "The latest situation in the presidential election", articleCategoryValue: "Business"),
            .init(image: "default", articleCategoryLabel: "Entertainment", articleName: "The latest situation in the presidential election", articleCategoryValue: "Entertainment"),
            .init(image: "default", articleCategoryLabel: "General", articleName: "The latest situation in the presidential election", articleCategoryValue: "General"),
            .init(image: "default", articleCategoryLabel: "Health", articleName: "The latest situation in the presidential election", articleCategoryValue: "Health"),
            .init(image: "default", articleCategoryLabel: "Science", articleName: "The latest situation in the presidential election", articleCategoryValue: "Science"),
            .init(image: "default", articleCategoryLabel: "Sports", articleName: "The latest situation in the presidential election", articleCategoryValue: "Sports"),
            .init(image: "default", articleCategoryLabel: "Technology", articleName: "The latest situation in the presidential election", articleCategoryValue: "Technology"),
       ]
    }
}

