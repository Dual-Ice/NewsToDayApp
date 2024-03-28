//
//  ProfilePresenter.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit

protocol ProfilePresenterViewProtocol: AnyObject {
    
    func render(with user: FirestoreUser?)
}

protocol ProfilePresenterProtocol: AnyObject {
    
    init(view: ProfilePresenterViewProtocol,
         router: ProfileRouterProtocol,
         user: FirestoreUser?)
    func goToLanguagesVC()
    func goToTermsAndConditionsVC()
    func goToAuthVC()
    
}


class ProfilePresenter: ProfilePresenterProtocol {
    
    var user: FirestoreUser?
    
    weak var view: ProfilePresenterViewProtocol?
    var router: ProfileRouterProtocol?
    
    required init(view: ProfilePresenterViewProtocol,
                  router: ProfileRouterProtocol,
                  user: FirestoreUser?
    ) {
        self.view = view
        self.router = router
        self.user = user
        self.view?.render(with: user)
    }
    
    func goToLanguagesVC() {
        router?.pushLanguagesVC()
    }
    
    func goToTermsAndConditionsVC() {
        router?.pushTermsAndConditionsVC()
    }
    
    func goToAuthVC() {
        router?.pushAuthVC()
    }
    
}
