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
            .init(image: "", articleCategory: "Business", articleName: ""),
            .init(image: "", articleCategory: "Entertainment", articleName: ""),
            .init(image: "", articleCategory: "General", articleName: ""),
            .init(image: "", articleCategory: "Health", articleName: ""),
            .init(image: "", articleCategory: "Science", articleName: ""),
            .init(image: "", articleCategory: "Sports", articleName: ""),
            .init(image: "", articleCategory: "Technology", articleName: ""),
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
