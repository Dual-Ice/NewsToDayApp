//
//  RecomendedPresenter.swift
//  NewsToDayApp
//
//  Created by Polina on 22.03.2024.
//


import Foundation

protocol RecomendedPresenterViewProtocol: AnyObject {
    
    
}

protocol RecomendedPresenterProtocol: AnyObject {
    
    init(view: RecomendedPresenterViewProtocol, router: RecomendedRouterProtocol)
    var data: [MockItem] { get }
}


class RecomendedPresenter: RecomendedPresenterProtocol {
    var data: [MockItem] = MockItem.getArticleModel()
    
    weak var view: RecomendedPresenterViewProtocol?
    var router: RecomendedRouterProtocol?
    
    required init(view: RecomendedPresenterViewProtocol, router: RecomendedRouterProtocol) {
        self.view = view
        self.router = router
        
    }
}
