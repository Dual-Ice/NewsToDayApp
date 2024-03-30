//
//  Theme.swift
//  NewsToDayApp
//
//  Created by Sergey on 30.03.2024.
//

import Foundation
import UIKit

enum Theme: String {
    case light, dark, system

   
    var uiInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return .unspecified
        }
    }
}

