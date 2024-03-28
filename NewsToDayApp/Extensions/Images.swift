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
            return UIImage(systemName: "person.fill")
        }
        
        static var categories: UIImage? {
            return UIImage(systemName: "square.grid.2x2.fill")
        }
        
        static var main: UIImage? {
            return UIImage(systemName: "house.fill")
        }
        
        static var bookmarkEmpty: UIImage? {
            return UIImage(systemName: "bookmark")
        }
        
        static var bookmarkFill: UIImage? {
            return UIImage(systemName: "bookmark.fill")
        }
        
        static var book: UIImage? {
            return UIImage(systemName: "text.book.closed")
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
        
        static var search: UIImage? {
            return UIImage(systemName: "magnifyingglass")
        }
        
        static var share: UIImage? {
            return UIImage(systemName: "arrowshape.turn.up.right")
        }
        
        static var userName: UIImage? {
            return UIImage(systemName: "person")
        }
        
        static var email: UIImage? {
            return UIImage(systemName: "envelope")
        }
        
        static var password: UIImage? {
            return UIImage(systemName: "lock")
        }
        
        static var secureInput: UIImage? {
            return UIImage(systemName: "eye")
        }
        
        static var signout: UIImage? {
            return UIImage(systemName: "rectangle.portrait.and.arrow.forward", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))
        }
        
        static var userAvatar: UIImage? {
            return UIImage(systemName: "person.crop.circle.fill")
        }
    }
    
    enum Images {
        static var noImage: UIImage? {
            return UIImage(named: "no-image")
        }
    }
}
