//
//  ProfileViewController.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit

class ProfileViewController: CustomViewController<ProfileView> {
    
    var presenter: ProfilePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        setDelegates()
        // pass user data here
        // customView.configView()
    }
    
    private func setDelegates(){
        customView.delegate = self
    }
}

extension ProfileViewController: ProfilePresenterViewProtocol {
    func render(with user: FirestoreUser) {
        customView.configure(with: user)
    }
}

extension ProfileViewController: ProfileViewDelegate {
    
    func handleSignOutButtonTap() {
        AuthManager.shared.signOut { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}

//MARK: - ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    func signOutButtonTapped() {
        print("tapped signout button")
    }
    
    func languageButtonTapped() {
        self.presenter?.goToLanguagesVC()
    }
    
    func termsAndConditionsButtonTapped() {
        self.presenter?.goToTermsAndConditionsVC()
    }
    
}
