//
//  MainPresenter.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit


protocol MainViewProtocol: AnyObject {
    func reloadCollectionView()
    func reloadSectionCollectionView(section: Int)
}

protocol MainPresenterProtocol: AnyObject {
    
    init(view: MainViewProtocol, router: MainRouterProtocol, newsManager: NewsManager,  imageManager: ImageManager )
    var mockData: [ListSectionModel] { get }
    var favorities: [MockItem : Bool] { get }
    var selectedIndexPath: IndexPath { get }
    func saveSelectedCell(indexPath: IndexPath)
    func handleCellEvent(article: MockItem, event: FavoriteButtonCellEvent)
    
    func goToDetailVC(data: Article?, isLiked: Bool)
    func goToRecomendedVC()
    
    func getNewsByCategory(category: String)
    var newsDataByCatagory: [Article] { get }
    var recomendedNews: [Article] { get }
    func getRecomendedNews(categoryArray: [String])
    func convertToString(arrayStrings: [String]) -> String
    func loadImageByCategories(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
    //func loadImageRecomended(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
    
}

class MainPresenter: MainPresenterProtocol {
    
    var selectedIndexPath: IndexPath = .init()
    var favorities: [MockItem : Bool] = .init()
    
    var newsDataByCatagory: [Article] = .init()
    var recomendedNews: [Article] = .init()
        
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
    private let imageManager: ImageManager
    private let newsManager: NewsManager
    
    var mockData: [ListSectionModel]{
        MockData().sectionData
    }
    
    required init(view: MainViewProtocol, router: MainRouterProtocol, newsManager: NewsManager, imageManager: ImageManager ) {
        self.view = view
        self.router = router
        self.newsManager = newsManager
        self.imageManager = imageManager
    }
    
    func saveSelectedCell(indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
    
    func getNewsByCategory(category: String){
        let request = NewsRequest(categories: [category])
        newsDataByCatagory = .init() //очищать массив при переключении категории
        newsManager.getNews(with: request) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    //print("data \(data)")
                    self.newsDataByCatagory = data.results ?? []
                    self.view?.reloadSectionCollectionView(section: 1)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getRecomendedNews(categoryArray: [String]){
        let request = NewsRequest(categories: categoryArray, size: 5)
        newsManager.getNews(with: request) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                   // print("DataNEWSRecomended \(data)")
                    self.recomendedNews = data.results ?? []
                    self.view?.reloadSectionCollectionView(section: 2)
                case .failure(let error):
                    print("DataNEWSRecomended error \(error.localizedDescription)")
                }
            }
        }
    }
    
    func loadImageByCategories(imageUrl: String?, completion: @escaping (UIImage?) -> Void) {
        imageManager.getImage(for: imageUrl, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    completion(image)
                case .failure(let error):
                    print(" error downloadImage \(error.localizedDescription)")
                    completion(nil)
                }
            }
        })
    }
//    
//    func loadImageRecomended(imageUrl: String?, completion: @escaping (UIImage?) -> Void) {
//        imageManager.getImage(for: imageUrl, completion: { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let image):
//                    completion(image)
//                case .failure(let error):
//                    print(" error downloadImage \(error.localizedDescription)")
//                    completion(nil)
//                }
//            }
//        })
//    }

    
    func convertToString(arrayStrings: [String]) -> String {
        return arrayStrings.joined(separator: ",")
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
    
    func goToDetailVC(data: Article?, isLiked: Bool) {
        router?.pushDetailVC(data: data, isLiked: isLiked)
    }
    
    func goToRecomendedVC() {
        router?.pushRecomendedView()
    }
    
}
