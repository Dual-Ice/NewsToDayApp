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
    
    init( view: DetailArticlePresenterViewProtocol, router: DetailArticleRouterProtocol, data: OneItem, isLiked: Bool)
    var data: OneItem { get }
    var isLiked: Bool { get }
    func dismissDetailArticleVC()
    
}


class DetailArticlePresenter: DetailArticlePresenterProtocol {
   
    weak var view: DetailArticlePresenterViewProtocol?
    var router: DetailArticleRouterProtocol?
    var data: OneItem
    var isLiked: Bool
    
    required init(view: DetailArticlePresenterViewProtocol, router: DetailArticleRouterProtocol, data: OneItem, isLiked: Bool ) {
        self.data = data
        self.isLiked = isLiked
        self.view = view
        self.router = router
    }
    
    func dismissDetailArticleVC(){
        router?.dismissDetailVC()
    }
}
