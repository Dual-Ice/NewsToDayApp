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
    func reloadOneCell(indexItem: Int, isLiked: Bool)
    //func updateFavoriteButton(indexPaths: [IndexPath], isLikedArray: [Bool] )
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: MainRouterProtocol, newsManager: NewsManager,  imageManager: ImageManager )
    var mockData: [ListSectionModel] { get }
    var selectedIndexPath: IndexPath { get }
    func saveSelectedCell(indexPath: IndexPath)
    func handleCellEvent(article: Int, event: FavoriteButtonCellEvent)
    
    func goToDetailVC(data: Article)
    func goToRecomendedVC()
    func goToSearchByWorldVC(searchWord: String)
    
    func getNewsByCategory(category: String)
    var newsDataByCatagory: [Article] { get }
    var recomendedNews: [Article] { get }
    var categoriesArray: [CategoriesModel] { get }
    var selectedCategory: String { get set }
    func getRecomendedNews(categoryArray: [String])
    func loadImageByCategories(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
    func filterCategoriesArray(categories: [String]) -> [String]
    func filterCategoriesForSelectedCategory(categories: [String]) -> String
    
    var imageCacheCourusel: [IndexPath: UIImage] { get set }
    var imageCacheRecomendation: [IndexPath: UIImage] { get set }
    
    func checkSelectedCategoriesRecommdations()
    func checkCouruselFavorite()
}

class MainPresenter: MainPresenterProtocol {
    
    var selectedIndexPath: IndexPath = .init()
    var selectedCategory: String = "business"
    var newsDataByCatagory: [Article] = .init()
    var recomendedNews: [Article] = .init()
    var categoriesArray: [CategoriesModel] = CategoriesModel.allCases
    
    var imageCacheCourusel: [IndexPath: UIImage] = [:]
    var imageCacheRecomendation: [IndexPath: UIImage] = [:]
        
    weak var view: MainViewProtocol?
    private var router: MainRouterProtocol?
    private let imageManager: ImageManager
    private let newsManager: NewsManager
    
    var mockData: [ListSectionModel]{
        [ .categories, .corusel, .recomendations]
    }
    
    private var arrayCatgories: [String] = []
    
    required init(view: MainViewProtocol, router: MainRouterProtocol, newsManager: NewsManager, imageManager: ImageManager ) {
        self.view = view
        self.router = router
        self.newsManager = newsManager
        self.imageManager = imageManager
        arrayCatgories = ["health", "sports"] //при иницилизации получаем сохраненный массив с категориями
        getNewsByCategory(category: selectedCategory)
        getRecomendedNews(categoryArray: arrayCatgories)
        
    }
    
    // MARK: - CheckSelectedCattegories for recomendation
    func checkSelectedCategoriesRecommdations(){
        let savedCategories =  ["health", "sports"]  //получаем сохраненный массив с категориям
        if savedCategories != arrayCatgories && !savedCategories.isEmpty {
            arrayCatgories = savedCategories
            getRecomendedNews(categoryArray: arrayCatgories)
            imageCacheRecomendation = [:] // почистить при новом запросе
        }
    }
    
    // MARK: - CheckCourusel favorite or not
    func checkCouruselFavorite(){ // вызвать во ViewWillAppear
        let savedCategories: [String : Article] = [:] // нужно заменить на сохраненные
        if !savedCategories.isEmpty{
            for (index,article) in newsDataByCatagory.enumerated() {
                if let savedArticle = savedCategories[article.articleId], savedArticle.isFavourite {
                    newsDataByCatagory[index].isFavourite = true
                }
            }
            
            for (index,article) in recomendedNews.enumerated() {
                if let savedArticle = savedCategories[article.articleId], savedArticle.isFavourite {
                    recomendedNews[index].isFavourite = true
                }
            }
            //reloadCollectionView
        }
    }
    
    // MARK: - Prepare CategoriesArray
    func filterCategoriesArray(categories: [String]) -> [String]{
        let filteredCategories = arrayCatgories.filter(categories.contains)
        let translatedArray = filteredCategories.translateCategories(filteredCategory: categories)
        let capitalizedCategories = translatedArray.capitalizingFirstLetterOfEachElement()
        return capitalizedCategories
    }
    
    func filterCategoriesForSelectedCategory(categories: [String]) -> String{
        let filteredCategory = categories.filter { $0 == selectedCategory }
        let translatedArray = filteredCategory.translateCategories(filteredCategory: categories)
        return translatedArray.first ?? ""
    }
    
    // MARK: - Save IndexPath For SelectedIndexPath
    func saveSelectedCell(indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
    
    // MARK: - Network
    func getNewsByCategory(category: String){
        let request = NewsRequest(categories: [category])
        newsDataByCatagory = .init() //очищать массив при переключении категории
        newsManager.getNews(with: request) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    //print("Data by category \(data)")
                    self.newsDataByCatagory = data.results ?? []
                    self.view?.reloadSectionCollectionView(section: 1)
                case .failure(let error):
                    print("DataByCategory error \(error.localizedDescription)")
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
                    print("DataNEWSRecomended \(data)")
                    self.recomendedNews = data.results ?? []
                    //self.view?.reloadCollectionView()
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
                case .failure(_):
                    completion(nil)
                }
            }
        })
    }
    // MARK: - Save To BookMarks
    func handleCellEvent(article: Int, event: FavoriteButtonCellEvent) {
        switch event {
        case .favoriteDidTapped:
            newsDataByCatagory[article].isFavourite = !newsDataByCatagory[article].isFavourite
            view?.reloadOneCell(indexItem: article, isLiked: newsDataByCatagory[article].isFavourite)
            if newsDataByCatagory[article].isFavourite == true {
                //сохранить в закладки
            } else {
                //удалить из закладок если нажал на кнопку в ячейки повторно
            }
        }
    }
    // MARK: - Navigation
    func goToDetailVC(data: Article) {
        router?.pushDetailVC(data: data)
    }
    
    func goToRecomendedVC() {
        router?.pushRecomendedView()
    }
    
    func goToSearchByWorldVC(searchWord: String){
        router?.pushSearchByWordScreen(searchWord: searchWord)
    }
    
}
