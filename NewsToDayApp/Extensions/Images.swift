//
//  Images.swift
//  NewsToDayApp
//
//  Created by  Maksim Stogniy on 18.03.2024.
//


import UIKit.UIImage

extension UIImage {
    enum Icons {
        static var user: UIImage? {
            return UIImage(named: "user")
        }
        
        static var userSelected: UIImage? {
            return UIImage(named: "user-selected")
        }
        
        static var categories: UIImage? {
            return UIImage(named: "categories")
        }
        
        static var categoriesSelected: UIImage? {
            return UIImage(named: "categories-selected")
        }
        
        static var main: UIImage? {
            return UIImage(named: "main")
        }
        
        static var mainSelected: UIImage? {
            return UIImage(named: "main-selected")
        }
        
        static var bookmark: UIImage? {
            return UIImage(named: "bookmark")
        }
        
        static var bookmarkSelected: UIImage? {
            return UIImage(named: "bookmark-selected")
        }
        
        static var bookmarkBordered: UIImage? {
            return UIImage(named: "bookmark-bordered")
        }
        
        static var bookmarkFilled: UIImage? {
            return UIImage(named: "bookmark-filled")
        }
        
        static var book: UIImage? {
            return UIImage(named: "book-alt")
        }
        
        static var angleRight: UIImage? {
            return UIImage(named: "angle-right")
        }
        
        static var arrowLeft: UIImage? {
            return UIImage(systemName: "arrow.backward", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))
        }

        static var chevronRight: UIImage? {
            return UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))
        }
        
        static var checkmark: UIImage? {
            return UIImage(systemName: "checkmark")
        }
        
        static var email: UIImage? {
            return UIImage(named: "email")
        }
        
        static var password: UIImage? {
            return UIImage(named: "password")
        }
        
        static var search: UIImage? {
            return UIImage(named: "search")
        }
        
        static var share: UIImage? {
            return UIImage(named: "share")
        }
        
        static var signout: UIImage? {
            return UIImage(systemName: "rectangle.portrait.and.arrow.forward", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))
        }
        
        static var userBasic: UIImage? {
            return UIImage(named: "user-basic")
        }
        
        static var userEditing: UIImage? {
            return UIImage(named: "user-editing")
        }
        
        static var passwordBasic: UIImage? {
            return UIImage(named: "password-basic")
        }
        
        static var passwordEditing: UIImage? {
            return UIImage(named: "password-editing")
        }
        
        static var emailBasic: UIImage? {
            return UIImage(named: "email-basic")
        }
        
        static var emailEditing: UIImage? {
            return UIImage(named: "email-editing")
        }
        
        static var secureInput: UIImage? {
            return UIImage(named: "secureInput")
        }
    }
}
