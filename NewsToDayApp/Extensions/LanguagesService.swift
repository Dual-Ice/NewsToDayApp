//
//  LanguageService.swift
//  NewsToDayApp
//
//  Created by  Maksim Stogniy on 25.03.2024.
//

import Foundation

final class LanguagesService {
    static func getAvailableLanguages() -> [String:String] {
        
        var languagesWithNames: [String:String] = [:]
        Languages.allCases.forEach { language in
            languagesWithNames[language.code] = language.label
        }
        
        return languagesWithNames
    }
    
    static func getCurrentLanguageCode() -> String {
        return Locale.preferredLanguages[0]
    }
    
    static func setLanguage(code: String) {
        
        if (code == "" || code == LanguagesService.getCurrentLanguageCode()) {
            return
        }
        
        UserDefaults.standard.set([code], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}
