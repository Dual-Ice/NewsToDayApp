//
//  Languages.swift
//  NewsToDayApp
//
//  Created by  Maksim Stogniy on 25.03.2024.
//

enum Languages: CaseIterable {
    case en, ru
}

extension Languages {
    var label: String {
        switch self {
        case .en:
            return "English"
        case .ru:
            return "Русский"
        }
    }
    
    var code: String {
        switch self {
        case .en:
            return "en-US"
        case .ru:
            return "ru-RU"
        }
    }
    
    func getLanguageCodeForRequest(_ language: String) -> String {
        switch language {
        case "en-US":
            return "en"
        case "ru-RU":
            return "ru"
        default:
            return "en"
        }
    }
}
