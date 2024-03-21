//
//  CoruselSectionModel.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//


import Foundation

struct MockDataModel{
    let articles: [OneItem]
}

struct OneItem: Hashable{
    let image: String?
    let articleCategory: String?
    let articleName: String?
}

extension MockDataModel{
    static func getArticleModel() -> [OneItem]{
        MockDataModel(articles: [OneItem(image: "mockImage", articleCategory: "Politic", articleName: "The latest situation in the presidential election"),OneItem(image: "mockImage", articleCategory: "Health", articleName: "The latest situation in the presidential election"),OneItem(image: "mockImage", articleCategory: "Science", articleName: "The latest situation in the presidential election"), OneItem(image: "mockImage", articleCategory: "Technology", articleName: "The latest situation in the presidential election"), OneItem(image: "mockImage", articleCategory: "Politic", articleName: "The latest situation in the presidential election"),OneItem(image: "mockImage", articleCategory: "Health", articleName: "The latest situation in the presidential election"),OneItem(image: "mockImage", articleCategory: "Science", articleName: "The latest situation in the presidential election"), OneItem(image: "mockImage", articleCategory: "Technology", articleName: "The latest situation in the presidential election")]).articles
    }
    static func  getCategoriesModel() -> [OneItem]{
        MockDataModel(articles: [OneItem(image: nil, articleCategory: "Business", articleName: nil),OneItem(image: nil, articleCategory: "Entertainment", articleName: nil), OneItem(image: nil, articleCategory: "General", articleName: nil),OneItem(image: nil, articleCategory: "Health", articleName: nil),OneItem(image: nil, articleCategory: "Science", articleName: nil),OneItem(image: nil, articleCategory: "Sports", articleName: nil),OneItem(image: nil, articleCategory: "Technology", articleName: nil)]).articles
    }
}

