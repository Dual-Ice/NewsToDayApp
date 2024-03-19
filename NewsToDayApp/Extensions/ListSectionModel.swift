//
//  ListSectionModel.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//

import Foundation
enum ListSectionModel{
    case categories([Category])
    case corusel([OneItemCourusel])
    case recomendations([OneItemCourusel])
    
    private var categoriesData: [Category] {
        switch self {
        case .categories(let categories):
            return categories
        case .corusel(_):
            return []
        case .recomendations(_):
            return []
        }
    }
    
    private var coruselsData: [OneItemCourusel] {
        switch self {
        case .categories(_):
            return []
        case .corusel(let corusel):
            return corusel
        case .recomendations(_):
            return []
        }
    }
    
    private var recomendationsData: [OneItemCourusel]  {
        switch self {
        case .categories(_):
            return []
        case .corusel(_):
            return []
        case .recomendations(let recomendations):
            return recomendations
        }
    }
    
    
    var countCategories: Int{
        categoriesData.count
    }
    
    var countCorusel: Int{
        coruselsData.count
    }
    
    var countRecomendations: Int{
        recomendationsData.count
    }
    
    var title: String{
        switch self{
        case .categories(_):
            return ""
        case .corusel(_):
            return ""
        case .recomendations(_):
            return "Recommended for you"
        }
    }
}
