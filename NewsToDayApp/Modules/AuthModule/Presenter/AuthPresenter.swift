//
//  AuthPresenter.swift
//  NewsToDayApp
//
//  Created by Vasilii Pronin on 22.03.2024.
//

import UIKit

protocol AuthPresenterViewProtocol: AnyObject {
    
    
}

protocol AuthPresenterProtocol: AnyObject {
    
    func showSignUpScreen()
    func showMainScreen()
    
    init(view: AuthPresenterViewProtocol, router: LoginRouterProtocol)
    
}


class AuthPresenter: AuthPresenterProtocol {
    
    weak var view: AuthPresenterViewProtocol?
    var router: LoginRouterProtocol?
    
    required init(view: AuthPresenterViewProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    
    func showSignUpScreen() {
        router?.showSignUpScreen()
    }
    
    func showMainScreen() {
        //
    }
}
