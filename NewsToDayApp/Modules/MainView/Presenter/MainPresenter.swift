//
//  MainPresenter.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    
}

protocol MainPresenterProtocol: AnyObject {
    
    init(view: MainViewProtocol, router: MainRouterProtocol)
    var mockData: [ListSectionModel] { get }
    
}

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
    
    var mockData: [ListSectionModel]{
        let data1 = MockDataModel.getCategoriesModel()
        let data2 = MockDataModel.getArticleModel()
        let data3 = MockDataModel.getArticleModel()
        return   [.categories(data1), .corusel(data2), .recomendations(data3)]
    }
    
    required init(view: MainViewProtocol, router: MainRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    
}
