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
    func reloadOneCell(indexItem: Int)
}

protocol MainPresenterProtocol: AnyObject {
    
    init(view: MainViewProtocol, router: MainRouterProtocol, newsManager: NewsManager,  imageManager: ImageManager )
    var mockData: [ListSectionModel] { get }
//    var favorities: [String : Bool] { get }
    var selectedIndexPath: IndexPath { get }
    func saveSelectedCell(indexPath: IndexPath)
    func handleCellEvent(article: Int, event: FavoriteButtonCellEvent)
    
    func goToDetailVC(data: Article?, isLiked: Bool)
    func goToRecomendedVC()
    func goToSearchByWorldVC(searchWord: String)
    
    func getNewsByCategory(category: String)
    var newsDataByCatagory: [Article] { get }
    var recomendedNews: [Article] { get }
    func getRecomendedNews(categoryArray: [String])
    func loadImageByCategories(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
    func filterCategoriesArray(categories: [String]) -> [String]
}

class MainPresenter: MainPresenterProtocol {
    
    var selectedIndexPath: IndexPath = .init()
   // var favorities: [String : Bool] = .init()
    
    var newsDataByCatagory: [Article] = .init()
    var recomendedNews: [Article] = .init()
//    var categoriesDataLabel = OneItem.allCategoryLabel
//    var categoriesDataValue = OneItem.allCategoryValues
        
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
    private let imageManager: ImageManager
    private let newsManager: NewsManager
    
    var mockData: [ListSectionModel]{
        MockData().sectionData
    }
    
    private var arrayCatgories: [String] {
        ["science", "health"]
    }
    
    required init(view: MainViewProtocol, router: MainRouterProtocol, newsManager: NewsManager, imageManager: ImageManager ) {
        self.view = view
        self.router = router
        self.newsManager = newsManager
        self.imageManager = imageManager
        getNewsByCategory(category: "business")
        getRecomendedNews(categoryArray: arrayCatgories)
    }
    
    func filterCategoriesArray(categories: [String]) -> [String]{
        print("categories \(categories))")
        print("filter categories array \(arrayCatgories.filter(categories.contains))")
        return arrayCatgories.filter(categories.contains)
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
        recomendedNews = .init() //очищать массив при смене массива категорий
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
    
    func handleCellEvent(article: Int, event: FavoriteButtonCellEvent) {
        switch event {
        case .favoriteDidTapped:
            newsDataByCatagory[article].isFavourite = !newsDataByCatagory[article].isFavourite
            view?.reloadOneCell(indexItem: article)
            if newsDataByCatagory[article].isFavourite == true {
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
    
    func goToSearchByWorldVC(searchWord: String){
        router?.pushSearchByWordScreen(searchWord: searchWord)
    }
    
}
