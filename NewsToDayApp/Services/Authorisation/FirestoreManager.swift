//
//  FirestoreManager.swift
//  NewsToDayApp
//
//  Created by Vasilii Pronin on 25.03.2024.
//

import Firebase

final class FirestoreManager {
    
    enum CollectionPath {
        static let username = "username"
        static let email = "email"
        static let image = "image"
        static let categories = "categories"
        static let articles = "articles"
    }
    
    static let shared = FirestoreManager()
    
    private let environment = "users"
    private let db = Firestore.firestore()
    
    private init() {}
    
    
    
    func setCollection(
        with user: FirestoreUser,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        var articlesJSON: [[String: Any]] = []
        for article in user.articles {
            do {
                let articleData = try JSONEncoder().encode(article)
                if let json = try JSONSerialization.jsonObject(with: articleData, options: []) as? [String: Any] {
                    articlesJSON.append(json)
                }
            } catch {
                print("Error encoding article to JSON: \(error)")
            }
        }
        
        db.collection(environment)
            .document(user.userID)
            .setData([
                CollectionPath.username: user.username,
                CollectionPath.email: user.email,
                CollectionPath.image: user.image,
                CollectionPath.articles: articlesJSON,
                CollectionPath.categories: user.categories
            ]) { error in
                if let error = error {
                    completion(false, error)
                    return
                }
                
                completion(true, nil)
            }
    }
    
    func fetchCollection(
        for id: String,
        completion: @escaping (FirestoreUser?, Error?) -> Void
    ) {
        db.collection(environment)
            .document(id)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                }
                
                if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let username = snapshotData[CollectionPath.username] as? String,
                   let email = snapshotData[CollectionPath.email] as? String {
                        let image = snapshotData[CollectionPath.image] as? String ?? ""
                        let categories = snapshotData[CollectionPath.categories] as? [String] ?? []
                        let articles = snapshotData[CollectionPath.articles] as? [[String: Any]] ?? []
                        var articlesArray: [Article] = []
                        for articleJSON in articles {
                            do {
                                let articleData = try JSONSerialization.data(withJSONObject: articleJSON, options: [])
                                let article = try JSONDecoder().decode(Article.self, from: articleData)
                                articlesArray.append(article)
                            } catch {
                                print("Error decoding article JSON: \(error)")
                            }
                        }
                        let user = FirestoreUser(
                            username: username,
                            email: email,
                            userID: id,
                            image: image,
                            categories: categories,
                            articles: articlesArray
                        )
                        completion(user, nil)
                }
            }
    }
}
