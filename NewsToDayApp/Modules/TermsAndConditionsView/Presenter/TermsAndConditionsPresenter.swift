//
//  TermsAndConditionsPresenter.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 22.03.2024.
//

import Foundation


protocol TermsAndConditionsPresenterViewProtocol: AnyObject {
    
}

protocol TermsAndConditionsPresenterProtocol: AnyObject {
    
    init( view: TermsAndConditionsPresenterViewProtocol, router: TermsAndConditionsRouterProtocol)
    func dismissTermsAndConditionsVC()
    
}


class TermsAndConditionsPresenter: TermsAndConditionsPresenterProtocol {
   
    weak var view: TermsAndConditionsPresenterViewProtocol?
    var router: TermsAndConditionsRouterProtocol?
    
    required init(view: TermsAndConditionsPresenterViewProtocol, router: TermsAndConditionsRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func dismissTermsAndConditionsVC(){
        router?.dismissTermsAndConditionsVC()
    }
}
