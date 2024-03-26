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
}
