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
    func getOnboardingCategories() -> [String]
    func clearOnboardingCategories()
    
    init(view: AuthPresenterViewProtocol, router: LoginRouterProtocol)
    
}


class AuthPresenter: AuthPresenterProtocol {
    
    weak var view: AuthPresenterViewProtocol?
    var router: LoginRouterProtocol?
    
    required init(view: AuthPresenterViewProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func getOnboardingCategories() -> [String] {
        let categories = UserDefaults.standard.array(forKey: "onboardingCategories")
        if categories == nil {
            return []
        }
        
        return categories as? [String] ?? []
    }
    func clearOnboardingCategories() {
        UserDefaults.standard.removeObject(forKey: "onboardingCategories")
    }
    
    
    func showSignUpScreen() {
        router?.showSignUpScreen()
    }
}
