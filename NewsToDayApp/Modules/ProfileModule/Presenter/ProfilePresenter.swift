//
//  ProfilePresenter.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit

protocol ProfilePresenterViewProtocol: AnyObject {
    
    func render(with user: FirestoreUser)
}

protocol ProfilePresenterProtocol: AnyObject {
    
    init(view: ProfilePresenterViewProtocol, router: ProfileRouterProtocol)
    func goToLanguagesVC()
    func goToTermsAndConditionsVC()
    
}


class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfilePresenterViewProtocol?
    var router: ProfileRouterProtocol?
    
    required init(view: ProfilePresenterViewProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.router = router
        AuthManager.shared.fetchUser { [weak self] user, error in
            guard let user = user else { return }
            self?.view?.render(with: user)
        }
    }
    
    func goToLanguagesVC() {
        router?.pushLanguagesVC()
    }
    
    func goToTermsAndConditionsVC() {
        router?.pushTermsAndConditionsVC()
    }
    
}
