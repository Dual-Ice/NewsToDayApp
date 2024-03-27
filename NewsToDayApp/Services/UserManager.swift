//
//  UserManager.swift
//  NewsToDayApp
//
//  Created by  Maksim Stogniy on 27.03.2024.
//

import Foundation
import UIKit.UIImage

final class UserManager {
    static let shared = UserManager()
//    user = 
    func updateUserAvatar(avatar: UIImage, completion: @escaping (Bool, Error?) -> Void) {
        AuthManager.shared.fetchUser { user, error in
           guard var user = user else { return }
            if let base64String = avatar.pngData()?.base64EncodedString() {
//                user.image = base64String
                FirestoreManager.shared.setCollection(
                    with: user
                ) { wasSet, error in
                    if let error = error {
                        completion(false, error)
                    }
                    completion(true, nil)
                }
            }
        }
    }
    
    func updateCategories(categories: [String]){}
    
    func switchArticleFavorite(article: Article) {}
    
//    func getFavoriteArticles() -> [Article] {}
    
//    func getCategories() -> [String] {}
}
