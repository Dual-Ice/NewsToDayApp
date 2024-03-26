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
        alert.addAction(UIAlertAction(title: NSLocalizedString("AuthScreenUDismissButtonText", comment: ""), style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
}


// Login alerts
extension AuthAlertManager {
    
    private func showInvalidEmailOrPasswordAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: NSLocalizedString("AuthScreenUserNameOrPasswordErrorTitle", comment: ""),
            message: NSLocalizedString("AuthScreenUserNameOrPasswordErrorMessage", comment: "")
        )
    }
}

// Register alerts
extension AuthAlertManager {
    
    private func showInvalidUsernameAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: NSLocalizedString("AuthScreenUserNameErrorTitle", comment: ""),
            message: NSLocalizedString("AuthScreenUserNameErrorMessage", comment: "")
        )
    }
    
    private func showInvalidEmailAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: NSLocalizedString("AuthScreenUserEmailErrorTitle", comment: ""),
            message: NSLocalizedString("AuthScreenUserEmailErrorMessage", comment: "")
        )
    }
    
    private func showInvalidPasswordAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: NSLocalizedString("AuthScreenUserPasswordErrorTitle", comment: ""),
            message: NSLocalizedString("AuthScreenUserPasswordErrorMessage", comment: "")
        )
    }
    
    private func showPasswordsMismatchAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: NSLocalizedString("AuthScreenUserPasswordRepeatErrorTitle", comment: ""),
            message: NSLocalizedString("AuthScreenUserPasswordRepeatErrorMessage", comment: "")
        )
    }
}
