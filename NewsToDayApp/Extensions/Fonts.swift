//
//  Fonts.swift
//  NewsToDayApp
//
//  Created by  Maksim Stogniy on 17.03.2024.
//

import UIKit.UIFont

extension UIFont {
    enum SystemFonts {
        enum Adamina {
            static let regular = "Adamina-Regular"
        }
        
        enum Inter {
            static let regular = "Inter-Regular"
            static let medium = "Inter-Medium"
            static let bold = "Inter-Bold"
            static let semibold = "Inter-Semibold"
        }
    }
    
    enum AdaminaFont {
        enum Regular {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: SystemFonts.Adamina.regular, size: size) ?? UIFont()
            }
        }
    }
    
    enum InterFont {
        enum Regular {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: SystemFonts.Inter.regular, size: size) ?? UIFont()
            }
        }
        
        enum Medium {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: SystemFonts.Inter.medium, size: size) ?? UIFont()
            }
        }
        
        enum Bold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: SystemFonts.Inter.bold, size: size) ?? UIFont()
            }
        }
        
        enum SemiBold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: SystemFonts.Inter.semibold, size: size) ?? UIFont()
            }
        }
    }
    
    enum TextFont {
        
        enum Screen {
            static let label = InterFont.SemiBold.size(of: 24)
            static let subLabel = InterFont.Regular.size(of: 16)
            static let text = InterFont.Regular.size(of: 16)
            static let button = InterFont.SemiBold.size(of: 16)
        }
        
        enum Splash {
            static let logoLabel = AdaminaFont.Regular.size(of: 64)
        }
        
        enum Main {
            static let searchInput = InterFont.Medium.size(of: 16)
            static let tag = InterFont.SemiBold.size(of: 12)
            static let articleCategory = InterFont.Regular.size(of: 12)
            static let articleLabel = InterFont.Bold.size(of: 16)
            static let recommendedLabel = InterFont.SemiBold.size(of: 20)
            static let seeAllLabel = InterFont.Medium.size(of: 14)
            static let recommendedArticleCategory = InterFont.Regular.size(of: 14)
            static let recommendedArticleLabel = InterFont.SemiBold.size(of: 16)
        }
        
        enum Bookmarks {
            static let articleCategory = InterFont.Regular.size(of: 14)
            static let articleLabel = InterFont.SemiBold.size(of: 16)
            static let emptyText = InterFont.Medium.size(of: 16)
        }
        
        enum Article {
            static let tag = InterFont.SemiBold.size(of: 12)
            static let label = InterFont.Bold.size(of: 20)
            static let authorName = InterFont.SemiBold.size(of: 16)
            static let authorLabel = InterFont.Regular.size(of: 14)
            static let articleLabel = InterFont.SemiBold.size(of: 16)
            static let articleText = InterFont.Regular.size(of: 16)
        }
        
        enum Profile {
            static let profileName = InterFont.SemiBold.size(of: 16)
            static let profileEmail = InterFont.Regular.size(of: 14)
        }

        
        enum TermsAndConditions {
            static let text = InterFont.Regular.size(of: 16)
        }
        
        enum Auth {
            static let signInUpLabel = InterFont.Medium.size(of: 16)
        }
    }
}
