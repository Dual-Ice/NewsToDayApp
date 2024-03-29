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
    init(view: MainViewProtocol,
         router: MainRouterProtocol,
         newsManager: NewsManager,
         imageManager: ImageManager
    )
    
    var mockData: [ListSectionModel] { get }
    var selectedIndexPath: IndexPath { get }
    func saveSelectedCell(indexPath: IndexPath)
    func handleCellEvent(article: Int, event: FavoriteButtonCellEvent, completion: @escaping (Error?) -> Void)
    
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
    
    var selectedIndexPath: IndexPath = IndexPath(item: 0, section: 0)
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
    
    private var arrayCategories: [String] = []
    
    required init(
        view: MainViewProtocol,
        router: MainRouterProtocol,
        newsManager: NewsManager,
        imageManager: ImageManager
    ) {
        self.view = view
        self.router = router
        self.newsManager = newsManager
        self.imageManager = imageManager
        arrayCategories = UserManager.shared.getCategories()
        getNewsByCategory(category: selectedCategory)
        getRecomendedNews(categoryArray: arrayCategories)
        
    }
    
    // MARK: - CheckSelectedCattegories for recomendation
    func checkSelectedCategoriesRecommdations(){
        let currentCategories = UserManager.shared.getCategories()
        print("currentCategories \(currentCategories)")
        if currentCategories != arrayCategories && !currentCategories.isEmpty {
            arrayCategories = currentCategories
            imageCacheRecomendation = [:] // почистить при новом запросе
            getRecomendedNews(categoryArray: arrayCategories)
        }
    }
    
    // MARK: - CheckCourusel favorite or not
    func checkCouruselFavorite(){ // вызвать во ViewWillAppear и при изменение данных в getNewsByCategory и getRecomendedNews
        //print("checkCouruselFavorite")
        let savedArticles: [Article] = UserManager.shared.getFavoriteArticles() // нужно заменить на сохраненные
       // print("SavedArticel \(savedArticles)")
       // if !savedArticles.isEmpty{
            let savedArticleIds = savedArticles.map { $0.articleId }

            for (index,article) in newsDataByCatagory.enumerated() {
                if savedArticleIds.contains(article.articleId) {
                    newsDataByCatagory[index].isFavourite = true
                    //print("NEWS TITLE \(newsDataByCatagory[index].title)")
                } else {
                    newsDataByCatagory[index].isFavourite = false // для чего
                }
            }

            for (index,article) in recomendedNews.enumerated() {
                if savedArticleIds.contains(article.articleId) {
                    recomendedNews[index].isFavourite = true
                } else {
                    recomendedNews[index].isFavourite = false
                }
            }
        //}
            //else {
//
////            recomendedNews.forEach { article in
////                article.isFavourite = false
////            }
//        }
        view?.reloadCollectionView()
    }
    
    // MARK: - Prepare CategoriesArray
    func filterCategoriesArray(categories: [String]) -> [String]{
        let filteredCategories = arrayCategories.filter(categories.contains)
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
//                    self.view?.reloadSectionCollectionView(section: 1)
                    self.checkCouruselFavorite()
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
//                    print("DataNEWSRecomended \(data)")
                    self.recomendedNews = data.results ?? []
                    //self.view?.reloadCollectionView()
//                    self.view?.reloadSectionCollectionView(section: 2)
                    self.checkCouruselFavorite()
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
    func handleCellEvent(article: Int, event: FavoriteButtonCellEvent, completion: @escaping (Error?) -> Void) {
        switch event {
        case .favoriteDidTapped:
            
            newsDataByCatagory[article].isFavourite = !newsDataByCatagory[article].isFavourite
            view?.reloadOneCell(indexItem: article, isLiked: newsDataByCatagory[article].isFavourite)
            if newsDataByCatagory[article].isFavourite == true {
                //сохранить в закладки
                UserManager.shared.addArticleFavorite(article: newsDataByCatagory[article]) { error in
                    completion(error)
                }
            } else {
                UserManager.shared.deleteArticleFromFavorite(articleId: newsDataByCatagory[article].articleId) { error in
                    completion(error)
                }
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
