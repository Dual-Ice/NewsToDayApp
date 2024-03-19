//
//  CoruselSectionModel.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//


import Foundation
struct CoruselSectionModel{
    let articles: [OneItemCourusel]
}
struct OneItemCourusel{
    let image: String
    let articleCategory: String
    let articleName: String
}
extension CoruselSectionModel{
    static func getCourusel() -> [OneItemCourusel]{
        CoruselSectionModel(articles: [OneItemCourusel(image: "mockImage", articleCategory: "Politic", articleName: "The latest situation in the presidential election"),OneItemCourusel(image: "mockImage", articleCategory: "Politic", articleName: "The latest situation in the presidential election"),OneItemCourusel(image: "mockImage", articleCategory: "Politic", articleName: "The latest situation in the presidential election"), OneItemCourusel(image: "mockImage", articleCategory: "Politic", articleName: "The latest situation in the presidential election")]).articles
    }
}
