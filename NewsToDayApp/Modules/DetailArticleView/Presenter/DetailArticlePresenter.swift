//
//  DetailArticlePresenter.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import Foundation


protocol DetailArticlePresenterViewProtocol: AnyObject {
    
    
}

protocol DetailArticlePresenterProtocol: AnyObject {
    
    init( view: DetailArticlePresenterViewProtocol, router: DetailArticleRouterProtocol, data: MockItem, isLiked: Bool)
    var data: MockItem { get }
    var isLiked: Bool { get }
    func dismissDetailArticleVC()
    
}


class DetailArticlePresenter: DetailArticlePresenterProtocol {
   
    weak var view: DetailArticlePresenterViewProtocol?
    var router: DetailArticleRouterProtocol?
    var data: MockItem
    var isLiked: Bool
    
    required init(view: DetailArticlePresenterViewProtocol, router: DetailArticleRouterProtocol, data: MockItem, isLiked: Bool ) {
        self.data = data
        self.isLiked = isLiked
        self.view = view
        self.router = router
    }
    
    func dismissDetailArticleVC(){
        router?.dismissDetailVC()
    }
}
