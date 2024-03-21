//
//  BooksmarksPresenter.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import Foundation

protocol BookmarksPresenterViewProtocol: AnyObject {
    
    
}

protocol BookmarksPresenterProtocol: AnyObject {
    
    init(view: BookmarksPresenterViewProtocol, router: BookmarksRouter)
    var data: [OneItem] { get }
}


class BookmarksPresenter: BookmarksPresenterProtocol {
    var data: [OneItem] = MockDataModel.getArticleModel()
    
    weak var view: BookmarksPresenterViewProtocol?
    var router: BookmarksRouter?
    
    required init(view: BookmarksPresenterViewProtocol, router: BookmarksRouter) {
        self.view = view
        self.router = router
    }
}
