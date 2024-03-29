//
//  String + ext.swift
//  NewsToDayApp
//
//  Created by Polina on 26.03.2024.
//

import Foundation
extension Array where Element == String {
    func capitalizingFirstLetterOfEachElement() -> [String] {
        return self.map { element in
            let firstLetter = element.prefix(1).capitalized
            let restOfString = element.dropFirst()
            return firstLetter + String(restOfString)
        }
    }
    
    func translateCategories(categoriesToTranslate: [String]) -> [String] {
        let arrayAllCategoriesValue = CategoriesModel.allCases.map { $0.categoryValue }
        let arrayAllCategoriesLabel = CategoriesModel.allCases.map { $0.categoryLabel }
        let indexes = categoriesToTranslate.compactMap { arrayAllCategoriesValue.firstIndex(of: $0) } // индексы отфильтрованных категорий в arrayAllCategoriesValue
        let translatedArray = indexes.compactMap {  arrayAllCategoriesLabel.indices.contains($0) ? arrayAllCategoriesLabel[$0] : nil } // по найденным индексам ищем соответсвие arrayAllCategoriesLabel и из соответсвий формируем новый массив
        return translatedArray
       }
}
