//
//  AuthRouter.swift
//  NewsToDayApp
//
//  Created by Vasilii Pronin on 22.03.2024.
//

import UIKit

protocol LoginRouterProtocol: AnyObject {
    
    func showSignUpScreen()
    
    init(navigationVC: UINavigationController)
    
}

class AuthRouter: LoginRouterProtocol {
    private let navigationVC: UINavigationController
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func showSignUpScreen() {
//        let vc = SignUpBuilder().buildSignUpView(
//            navigationController: navigationVC,
//            router: self
//        )
//        navigationVC.pushViewController(vc, animated: true)
    }
}
