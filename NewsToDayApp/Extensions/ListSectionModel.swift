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
