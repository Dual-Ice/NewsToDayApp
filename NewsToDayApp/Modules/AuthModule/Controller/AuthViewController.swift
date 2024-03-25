//
//  AuthViewController.swift
//  NewsToDayApp
//
//  Created by Vasilii Pronin on 22.03.2024.
//

import UIKit

//final class LoginViewController: CustomViewController<LoginView> {
//    
//    var presenter: LoginPresenterProtocol?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        (view as! LoginView).delegate = self
//    }
//}
//
//extension LoginViewController: LoginPresenterViewProtocol {
//    
//}
//
//extension LoginViewController: LoginViewDelegate {
//    
//    func handleLoginTap(with userRequest: LoginUserRequest) {
//        AuthManager.shared.signIn(with: userRequest) { error in
//            
//        }
//    }
//    
//    func handleSignUpTap() {
//        presenter?.showSignUpScreen()
//    }
//    
//    func showAlert(for alertType: AlertType.Login) {
//        
//    }
//}

final class AuthViewController: CustomViewController<AuthenticationView> {
    
    var presenter: AuthPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
    }
}

extension AuthViewController: AuthPresenterViewProtocol {
    
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
        AuthManager.shared.registerUser(with: request) { wasRegistered, error in
            //
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    func showLoginAlert(for status: AuthAlertManager.LoginAlert) {
        AuthAlertManager.shared.showLoginAlert(on: self, for: status)
    }
    
    func showRegisterAlert(for status: AuthAlertManager.RegisterAlert) {
        AuthAlertManager.shared.showRegisterAlert(on: self, for: status)
    }
}
