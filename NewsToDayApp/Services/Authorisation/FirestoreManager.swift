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
//        static let categories = "categories"
//        static let articles = "articles"
    }
    
    static let shared = FirestoreManager()
    
    private let environment = "users"
    private let db = Firestore.firestore()
    
    private init() {}
    
    
    
    func setCollection(
        with user: FirestoreUser,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        db.collection(environment)
            .document(user.userID)
            .setData([
                CollectionPath.username: user.username,
                CollectionPath.email: user.email
//                CollectionPath.image: user.image as Any,
//                CollectionPath.articles: user.articles,
//                CollectionPath.categories: user.categories
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
                    let image = snapshotData[CollectionPath.image] as? String
//                   let categories = snapshotData[CollectionPath.categories] as? [String],
//                   let articles = snapshotData[CollectionPath.articles] as? [Article] {
                    let user = FirestoreUser(
                        username: username,
                        email: email,
                        userID: id,
                        image: image
//                        categories: categories,
//                        articles: articles
                    )
                    completion(user, nil)
                }
            }
    }
}
