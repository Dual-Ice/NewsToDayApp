//
//  ProfileViewController.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import Foundation
import UIKit

class ProfileViewController: CustomViewController<ProfileView> {
    
    var presenter: ProfilePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    private func setDelegates(){
        customView.delegate = self
    }
}

extension ProfileViewController: ProfilePresenterViewProtocol {
    
    
}

//MARK: - ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    func signOutButtonTapped() {
        print("tapped signout button")
    }
    
    func languageButtonTapped() {
        print("tapped language button")
        self.presenter?.goToLanguagesVC()
    }
    
    func termsAndConditionsButtonTapped() {
        print("tapped terms and conditions button ")
        self.presenter?.goToTermsAndConditionsVC()
    }
    
}
