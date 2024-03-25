//
//  AuthAlertManager.swift
//  NewsToDayApp
//
//  Created by Vasilii Pronin on 24.03.2024.
//

import UIKit


final class AuthAlertManager {
    
    enum LoginAlert {
        case invalidEmailOrPassword
    }
    
    enum RegisterAlert {
        case invalidUsername
        case invalidEmail
        case invalidPassword
        case passwordsMismatch
    }
    
    static let shared = AuthAlertManager()
    
    private init() {}
    
    func showLoginAlert(
        on viewController: UIViewController,
        for status: LoginAlert
    ) {
        switch status {
        case .invalidEmailOrPassword:
            showInvalidEmailOrPasswordAlert(on: viewController)
        }
    }
    
    func showRegisterAlert(
        on viewController: UIViewController,
        for status: RegisterAlert
    ) {
        switch status {
        case .invalidUsername:
            showInvalidUsernameAlert(on: viewController)
        case .invalidEmail:
            showInvalidEmailAlert(on: viewController)
        case .invalidPassword:
            showInvalidPasswordAlert(on: viewController)
        case .passwordsMismatch:
            showPasswordsMismatchAlert(on: viewController)
        }
    }
    
    private func presentBasicAlert(
        on viewController: UIViewController,
        title: String,
        message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
}


// Login alerts
extension AuthAlertManager {
    
    private func showInvalidEmailOrPasswordAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: "Invalid username or password.",
            message: "Please try again."
        )
    }
}

// Register alerts
extension AuthAlertManager {
    
    private func showInvalidUsernameAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: "Invalid username",
            message: "Username must contain at least 4 symbols. Please enter correct username."
        )
    }
    
    private func showInvalidEmailAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: "Invalid email",
            message: "Please enter correct username"
        )
    }
    
    private func showInvalidPasswordAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: "Invalid password",
            message: "Password must contain at least 6 symbols. Please enter correct password."
        )
    }
    
    private func showPasswordsMismatchAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: "Password mismatch",
            message: "Passwords do not match. Please try again."
        )
    }
}
