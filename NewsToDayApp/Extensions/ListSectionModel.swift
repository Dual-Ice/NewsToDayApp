//
//  ListSectionModel.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//

import Foundation

enum ListSectionModel{
    case categories
    case corusel
    case recomendations
    
//    private var itemsData: [MockItem] {
//        switch self {
//        case .categories(let categories):
//            return categories
//        case .corusel(let corusel):
//            return corusel
//        case .recomendations(let recomendations):
//            return recomendations
//        }
//    }
//    
//    var countData: Int{
//        itemsData.count
//    }
    
    var title: String{
        switch self{
        case .categories:
            return ""
        case .corusel:
            return ""
        case .recomendations:
            return NSLocalizedString("ListSectionModelTitle", comment: "")
        }
    }
}
