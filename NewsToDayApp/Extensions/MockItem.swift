//
//  CoruselSectionModel.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//


import Foundation

struct MockItem: Hashable{
    let image: String
    let articleCategory: String
    let articleName: String
}

extension MockItem{
    static func  getArticleModel() -> [MockItem]{
        [
            .init(image: "default", articleCategory: "Business", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Entertainment", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "General", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Health", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Science", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Sports", articleName: "The latest situation in the presidential election"),
            .init(image: "default", articleCategory: "Technology", articleName: "The latest situation in the presidential election"),
       ]
    }
}

