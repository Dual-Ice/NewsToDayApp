//
//  ListSectionModel.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//

import Foundation

enum ListSectionModel{
    case categories([MockItem])
    case corusel([MockItem])
    case recomendations([MockItem])
    
    private var itemsData: [MockItem] {
        switch self {
        case .categories(let categories):
            return categories
        case .corusel(let corusel):
            return corusel
        case .recomendations(let recomendations):
            return recomendations
        }
    }
    
    var countData: Int{
        itemsData.count
    }
    
    var title: String{
        switch self{
        case .categories(_):
            return ""
        case .corusel(_):
            return ""
        case .recomendations(_):
            return NSLocalizedString("ListSectionModelTitle", comment: "")
        }
    }
}
