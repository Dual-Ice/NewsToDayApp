//
//  AuthManager.swift
//  NewsToDayApp
//
//  Created by Vasilii Pronin on 22.03.2024.
//

import Foundation
import Firebase

protocol AuthManagerProtocol {
    
    func registerUser(with registerRequest: RegisterUserRequest)
    func signInUser(with loginRequest: LoginUserRequest)
    func signInWithApple()
}

final class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
}

extension AuthManager {
   
    
    func checkAuth() -> Bool {
        Auth.auth().currentUser != nil
    }
    func registerUser(
        with userRequest: RegisterUserRequest,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(
            withEmail: email,
            password: password
        ) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let user = FirestoreUser(
                username: username,
                email: email,
                userID: resultUser.uid
            )
            
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
    
    func signIn(
        with userRequest: LoginUserRequest,
        completion: @escaping (Error?) -> Void
    ) {
        Auth.auth().signIn(
            withEmail: userRequest.email,
            password: userRequest.password
        ) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    func fetchUser(completion: @escaping (FirestoreUser?, Error?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        FirestoreManager.shared.fetchCollection(for: userID) { user, error in
            if let error = error {
                completion(nil, error)
            }
            completion(user, nil)
        }
    }
}
