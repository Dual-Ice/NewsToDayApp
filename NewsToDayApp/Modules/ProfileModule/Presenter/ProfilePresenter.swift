//
//  ProfilePresenter.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import Foundation
import UIKit

protocol ProfilePresenterViewProtocol: AnyObject {
    
    
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
    }
    
    func goToLanguagesVC() {
        router?.pushLanguagesVC()
    }
    
    func goToTermsAndConditionsVC() {
        router?.pushTermsAndConditionsVC()
    }
    
}
