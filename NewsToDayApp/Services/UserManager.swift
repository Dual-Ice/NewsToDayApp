//
//  UserManager.swift
//  NewsToDayApp
//
//  Created by  Maksim Stogniy on 27.03.2024.
//

import Foundation
import UIKit.UIImage

struct UserData {
    let username: String
    let email: String
    let image: UIImage?
}

final class UserManager {
    static let shared = UserManager()
    private var user: FirestoreUser?
    
    private init() {}
    
    func setUser(userObject: FirestoreUser) {
        user = userObject
    }
    
    func syncUser(userObject: FirestoreUser){
        guard let backupedUser = getUserFromUserDefaults() else {
            user = userObject
            return
        }
        if backupedUser.userID != userObject.userID {
            user = userObject
            return
        }
        
        if !areEqual(backupedUser, userObject) {
            user = backupedUser
            DispatchQueue.main.async {
                FirestoreManager.shared.setCollection(
                    with: self.user!
                ) { success, error in
                    if let error = error {
                        print(error)
                    }
                }
            }
        }
        
    }
    
    func backupUser() {
        do {
            let encodedUser = try JSONEncoder().encode(user)
            UserDefaults.standard.set(encodedUser, forKey: "currentUser")
        } catch {
            print("Error encoding user: \(error)")
        }
    }
    
    private func areEqual(_ user1: FirestoreUser, _ user2: FirestoreUser) -> Bool {
        guard let jsonData1 = try? user1.toJSON(),
              let jsonData2 = try? user2.toJSON() else {
            return false
        }
        return jsonData1 == jsonData2
    }
    
    private func getUserFromUserDefaults() -> FirestoreUser? {
        let defaults = UserDefaults.standard
            
        guard let userData = defaults.data(forKey: "currentUser") else {
            return nil
        }
        
        do {
            let user = try JSONDecoder().decode(FirestoreUser.self, from: userData)
            return user
        } catch {
            print("Error decoding user data:", error)
            return nil
        }
    }
    
    func updateUserAvatar(avatar: UIImage, completion: @escaping (Error?) -> Void) {
        if let base64String = avatar.pngData()?.base64EncodedString() {
            let pathToAvatar = saveUserAvatarToUD(with: user?.userID ?? "", avatar: base64String)
            user?.image = pathToAvatar
            DispatchQueue.main.async {
                FirestoreManager.shared.setCollection(
                    with: self.user!
                ) { success, error in
                    if let error = error {
                        completion(error)
                    }
                    
                    completion(nil)
                }
            }
        } else {
            let error = NSError(domain: "YourDomain", code: 2, userInfo: [NSLocalizedDescriptionKey: "Error converting image to base64"])
            completion(error)
        }
    }
    
    func updateCategories(categories: [String], completion: @escaping (Error?) -> Void){
        user?.categories = categories
        DispatchQueue.main.async {
            FirestoreManager.shared.setCollection(
                with: self.user!
            ) { success, error in
                if let error = error {
                    completion(error)
                }
                
                completion(nil)
            }
        }
    }
    
    func addArticleFavorite(article: Article, completion: @escaping (Error?) -> Void) {
        user?.articles.append(article)
        
        DispatchQueue.main.async {
            FirestoreManager.shared.setCollection(
                with: self.user!
            ) { success, error in
                if let error = error {
                    completion(error)
                }
                
                completion(nil)
            }
        }
    }
    
    func deleteArticleFromFavorite(articleId: String, completion: @escaping (Error?) -> Void) {
        if let index = user?.articles.firstIndex(where: { $0.articleId == articleId }) {
            user?.articles.remove(at: index)
        }
        
        DispatchQueue.main.async {
            FirestoreManager.shared.setCollection(
                with: self.user!
            ) { success, error in
                if let error = error {
                    completion(error)
                }
                
                completion(nil)
            }
        }
    }
    
    func getFavoriteArticles() -> [Article] {
        return user?.articles ?? []
    }
    
    func getCategories() -> [String] {
        return user?.categories ?? []
    }
    
    func getUserProfileData() -> UserData {
        return UserData(
            username: user!.username,
            email: user!.email,
            image: makeUserImage()
        )
    }
    
    private func makeUserImage() -> UIImage? {
        guard let imageData = getUserAvatarFromUD(by: user?.userID ?? ""), !imageData.isEmpty else {
            return nil
        }
            
        guard let imageDataDecoded = Data(base64Encoded: imageData) else {
            return nil
        }
        
        return UIImage(data: imageDataDecoded)
    }
    
    private func getKeyForUserAvatar(by userId: String) -> String {
        return "user-" + userId + "-avatar"
    }
    
    private func saveUserAvatarToUD(with userId: String, avatar: String) -> String {
        let key = getKeyForUserAvatar(by: userId)
        UserDefaults.standard.set(avatar, forKey: key)
        return key
    }
    
    private func getUserAvatarFromUD(by userId: String) -> String? {
        let key = getKeyForUserAvatar(by: userId)
        let defaults = UserDefaults.standard
            
        guard let avatarString = defaults.string(forKey: key) else {
            return nil
        }
        
        return avatarString
    }
    
    
}
