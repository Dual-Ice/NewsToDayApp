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
    var favorities: [MockItem : Bool] { get }
    var selectedIndexPath: IndexPath { get }
    func saveSelectedCell(indexPath: IndexPath)
    func handleCellEvent(article: MockItem, event: FavoriteButtonCellEvent)
    
    func goToDetailVC(data: MockItem, isLiked: Bool)
    
}

class MainPresenter: MainPresenterProtocol {
    
    var selectedIndexPath: IndexPath = .init()
    var favorities: [MockItem : Bool] = .init()
        
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
    
    var mockData: [ListSectionModel]{
        MockData().sectionData
    }
    
    required init(view: MainViewProtocol, router: MainRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func saveSelectedCell(indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
    
    func handleCellEvent(article: MockItem, event: FavoriteButtonCellEvent) {
        switch event {
        case .favoriteDidTapped:
            favorities[article] = !(favorities[article] ?? false) //если нет значения то ?? вернет false и favorities[article] = !false то есть true
            print("tapped favorite button on cell\(favorities)")
            view?.reloadCollectionView()
            if favorities[article] == true {
                //сохранить в закладки
            } else {
                //удалить из закладок если нажал на кнопку в ячейки повторно
            }
        }
    }
    
    func goToDetailVC(data: MockItem, isLiked: Bool) {
        router?.pushDetailVC(data: data, isLiked: isLiked)
    }
    
}
