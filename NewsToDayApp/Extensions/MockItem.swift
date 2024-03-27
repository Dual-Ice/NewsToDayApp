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
    let id: String
}

extension MockItem{
    static func  getArticleModel() -> [MockItem]{
        [
            .init(image: "default", articleCategoryLabel: "Business", articleName: "The latest situation in the presidential election", articleCategoryValue: "Business", id: "1"),
            .init(image: "default", articleCategoryLabel: "Entertainment", articleName: "The latest situation in the presidential election", articleCategoryValue: "Entertainment", id: "2"),
            .init(image: "default", articleCategoryLabel: "General", articleName: "The latest situation in the presidential election", articleCategoryValue: "General", id: "3"),
       ]
    }
}

