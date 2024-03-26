//
//  OneItem.swift
//  NewsToDayApp
//
//  Created by Polina on 26.03.2024.
//

import Foundation
protocol OneItemProtocol{
    var categoryLabel: String { get }
    var categoryValue: String { get }
}

   
enum OneItem: CaseIterable {
    case business, health, science, sports, technology, crime, education, entertainment, environment, food, lifestyle, politics
}

extension OneItem: OneItemProtocol{
    var categoryLabel: String {
        switch self{
        case .business:
            return "Business"
        case .health:
            return "Health"
        case .science:
            return "Science"
        case .sports:
            return "Sports"
        case .technology:
            return "Technology"
        case .crime:
            return "Crime"
        case .education:
            return "Education"
        case .entertainment:
            return "Entertainment"
        case .environment:
            return "Environment"
        case .food:
            return "Food"
        case .lifestyle:
            return "Lifestyle"
        case .politics:
            return "Politics"
        }
    }

    var categoryValue: String {
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
        }
    }
    
    static var allCategoryValues: [String] {
           return OneItem.allCases.map { $0.categoryValue }
       }
    
    static var allCategoryLabel: [String] {
           return OneItem.allCases.map { $0.categoryLabel }
       }
}
