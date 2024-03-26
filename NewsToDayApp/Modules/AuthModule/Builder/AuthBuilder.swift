//
//  AuthBuilder.swift
//  NewsToDayApp
//
//  Created by Vasilii Pronin on 22.03.2024.
//

import UIKit

protocol AuthBuilderProtocol: AnyObject {
    
    func buildLoginView(
        navigationController: UINavigationController
    ) -> UIViewController
}

final class AuthBuilder: AuthBuilderProtocol {
        
    func buildLoginView(
        navigationController: UINavigationController
    ) -> UIViewController {
        let vc = AuthViewController()
        let router = AuthRouter(navigationVC: navigationController)
        let presenter = AuthPresenter(view: vc, router: router)
        vc.presenter = presenter
        
        return vc
    }
}
