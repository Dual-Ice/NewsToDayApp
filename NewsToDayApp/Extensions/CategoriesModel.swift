//
//  CategoriesModel.swift
//  NewsToDayApp
//
//  Created by Polina on 27.03.2024.
//

import Foundation
protocol CategoriesModelProtocol{
    var categoryLabel: String { get }
    var categoryValue: String { get }
    var emojy: String { get }
}

   
enum CategoriesModel: CaseIterable {
    case business, health, science, sports, technology, crime, education, entertainment, environment, food, lifestyle, politics, other, top, tourism, world, domestic
}

extension CategoriesModel: CategoriesModelProtocol{
    var emojy: String {
        switch self {
        case .business:
            return "💼"
        case .health:
            return "🩺"
        case .science:
            return "🔬"
        case .sports:
            return "⚽️"
        case .technology:
            return "💻"
        case .crime:
            return "🚓"
        case .education:
            return "🎓"
        case .entertainment:
            return "🎬"
        case .environment:
            return "🌳"
        case .food:
            return "🍔"
        case .lifestyle:
            return "🛋️"
        case .politics:
            return "🗳️"
        case .other:
               return "❓"
           case .top:
               return "🔝"
           case .tourism:
               return "🏝️"
           case .world:
               return "🌐"
           case .domestic:
               return "🏠"
           }
    }

    var categoryValue: String {
        switch self{
        case .business:
            return "business"
        case .health:
            return "health"
        case .science:
            return "science"
        case .sports:
            return "sports"
        case .technology:
            return "technology"
        case .crime:
            return "crime"
        case .education:
            return "education"
        case .entertainment:
            return "entertainment"
        case .environment:
            return "environment"
        case .food:
            return "food"
        case .lifestyle:
            return "lifestyle"
        case .politics:
            return "politics"
        case .other:
            return "other"
        case .top:
            return "top"
        case .tourism:
            return "tourism"
        case .world:
            return "world"
        case .domestic:
            return "domestic"
        }
    }

    var categoryLabel: String {
        switch self{
        case .business:
            return NSLocalizedString("CategoriesBusiness", comment: "")
        case .health:
            return NSLocalizedString("CategoriesHealth", comment: "")
        case .science:
            return NSLocalizedString("CategoriesScience", comment: "")
        case .sports:
            return NSLocalizedString("CategoriesSports", comment: "")
        case .technology:
            return NSLocalizedString("CategoriesTechnology", comment: "")
        case .crime:
            return NSLocalizedString("CategoriesCrime", comment: "")
        case .education:
            return NSLocalizedString("CategoriesEducation", comment: "")
        case .entertainment:
            return NSLocalizedString("CategoriesEntertainment", comment: "")
        case .environment:
            return NSLocalizedString("CategoriesEnvironment", comment: "")
        case .food:
            return NSLocalizedString("CategoriesFood", comment: "")
        case .lifestyle:
            return NSLocalizedString("CategoriesLifestyle", comment: "")
        case .politics:
            return NSLocalizedString("CategoriesPolitics", comment: "")
        case .other:
            return NSLocalizedString("CategoriesOther", comment: "")
        case .top:
            return NSLocalizedString("CategoriesTop", comment: "")
        case .tourism:
            return NSLocalizedString("CategoriesTourism", comment: "")
        case .world:
            return NSLocalizedString("CategoriesWorld", comment: "")
        case .domestic:
            return NSLocalizedString("CategoriesDomestic", comment: "")
        }
    }
}
