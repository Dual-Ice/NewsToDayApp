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
        
        static var bookmarkLight: UIImage? {
            return UIImage(named: "bookmark-light")
        }
        
        static var book: UIImage? {
            return UIImage(named: "book-alt")
        }
        
        static var angleRight: UIImage? {
            return UIImage(named: "angle-right")
        }
        
        static var check: UIImage? {
            return UIImage(named: "check")
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
            return UIImage(named: "signout")
        }
    }
}
