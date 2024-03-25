//
//  LanguagesPresenter.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 22.03.2024.
//

import Foundation


protocol LanguagesPresenterViewProtocol: AnyObject {
}

protocol LanguagesPresenterProtocol: AnyObject {
    
    init( view: LanguagesPresenterViewProtocol, router: LanguagesRouterProtocol)
    func dismissLanguagesVC()
    
}


class LanguagesPresenter: LanguagesPresenterProtocol {
   
    weak var view: LanguagesPresenterViewProtocol?
    var router: LanguagesRouterProtocol?
    
    required init(view: LanguagesPresenterViewProtocol, router: LanguagesRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func dismissLanguagesVC(){
        router?.dismissLanguagesVC()
    }
}
