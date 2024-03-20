//
//  MainPresenter.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func reloadCollectionView()
}

protocol MainPresenterProtocol: AnyObject {
    
    init(view: MainViewProtocol, router: MainRouterProtocol)
    var mockData: [ListSectionModel] { get }
    var favorities: [OneItem : Bool] { get }
    func handleCellEvent(article: OneItem, event: FavoriteButtonCellEvent)
    
}

class MainPresenter: MainPresenterProtocol {
    var favorities: [OneItem : Bool] = .init()
        
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
    
    func handleCellEvent(article: OneItem, event: FavoriteButtonCellEvent) {
        switch event {
        case .favoriteDidTapped:
            favorities[article] = !(favorities[article] ?? false) //если нет значения то ?? вернет false и favorities[article] = !false то есть true
            print(favorities)
            view?.reloadCollectionView()
            if favorities[article] == true {
                //сохранить в закладки
            } else {
                //удалить из закладок если нажал на кнопку в ячейки повторно
            }
        }
    }
    
}
