//
//  AuthViewController.swift
//  NewsToDayApp
//
//  Created by Vasilii Pronin on 22.03.2024.
//

import UIKit

final class AuthViewController: CustomViewController<AuthenticationView> {
    
    var presenter: AuthPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
    }
}

extension AuthViewController: AuthPresenterViewProtocol {
    func goToCategories() {
        let vc = CategoriesBuilder().buildCategoriesView(mode: .categoriesOnbording)
        vc.modalPresentationStyle = .fullScreen
        self.view?.window?.rootViewController = vc
    }
    
}

extension AuthViewController: AuthenticationViewDelegate {
    
    func handleLoginButtonTap(with request: LoginUserRequest) {
        AuthManager.shared.signIn(with: request) { error in
            //
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    func handleRegisterButtonTap(with request: RegisterUserRequest) {
        AuthManager.shared.registerUser(with: request) { registeredUser, error in
            if let error = error {
                AuthAlertManager.shared.showDefaultAlert(on: self, title: NSLocalizedString("AuthSceenRegistrationErrorTitle", comment: ""), message: error.localizedDescription)
                return
            }
            
            guard let user = registeredUser else {
                AuthAlertManager.shared.showDefaultAlert(on: self, title: NSLocalizedString("AuthSceenRegistrationErrorTitle", comment: ""), message: NSLocalizedString("AuthSceenRegistrationUnexpectedError", comment: ""))
                return
            }
            UserManager.shared.setUser(userObject: user)
            self.presenter.goToCategories()
        }
    }
    
    func showLoginAlert(for status: AuthAlertManager.LoginAlert) {
        AuthAlertManager.shared.showLoginAlert(on: self, for: status)
    }
    
    func showRegisterAlert(for status: AuthAlertManager.RegisterAlert) {
        AuthAlertManager.shared.showRegisterAlert(on: self, for: status)
    }
    
}
