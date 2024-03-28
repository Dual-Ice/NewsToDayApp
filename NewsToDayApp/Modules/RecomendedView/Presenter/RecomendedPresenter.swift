//
//  RecomendedPresenter.swift
//  NewsToDayApp
//
//  Created by Polina on 22.03.2024.
//


import UIKit

protocol RecomendedPresenterViewProtocol: AnyObject {
    func reloadTableView()
    
}

protocol RecomendedPresenterProtocol: AnyObject {
    
    init(view: RecomendedPresenterViewProtocol,
         router: RecomendedRouterProtocol,
         newsManager: NewsManager,
         imageManager: ImageManager,
         user: FirestoreUser?,
         searchWord: String?
    )
    var data: [Article] { get }
    var imageCacheRecomendation: [IndexPath: UIImage] { get set }
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
    func goToDetailVC(data: Article)
    func dismisRecomendedVC()
    func filterCategoriesArray(categories: [String]) -> [String]
}


class RecomendedPresenter: RecomendedPresenterProtocol {
    var data: [Article] = .init()
    
    var imageCacheRecomendation: [IndexPath: UIImage] = [:]
    
    weak var view: RecomendedPresenterViewProtocol?
    var router: RecomendedRouterProtocol?
    private let newsManager: NewsManager
    private let imageManager: ImageManager
    private let searchWord: String?
    
    var user: FirestoreUser?
    private var arrayCatgories: [String] = .init()
    
    required init(view: RecomendedPresenterViewProtocol,
                  router: RecomendedRouterProtocol,
                  newsManager: NewsManager,
                  imageManager: ImageManager,
                  user: FirestoreUser?,
                  searchWord: String?) {
        self.view = view
        self.router = router
        self.newsManager = newsManager
        self.imageManager = imageManager
        self.searchWord = searchWord
        self.user = user
        self.arrayCatgories = user?.categories ?? []
        searchWord != nil ? getRecomendedNews(request: NewsRequest(query: searchWord)) : getRecomendedNews(request: NewsRequest(categories: arrayCatgories))
    }
    
    // MARK: - FilterCategories and translate
    func filterCategoriesArray(categories: [String]) -> [String]{
        if searchWord == nil{
            let filteredCategories = arrayCatgories.filter(categories.contains)
            let translatedArray = filteredCategories.translateCategories(filteredCategory: categories)
            let capitalizedCategories = translatedArray.capitalizingFirstLetterOfEachElement()
            return capitalizedCategories
        } else {
            return categories.translateCategories(filteredCategory: categories).capitalizingFirstLetterOfEachElement()
        }
    }

    // MARK: - Network
    private func getRecomendedNews(request: NewsRequest){
        newsManager.getNews(with: request) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self.data = data.results ?? []
//                    self.view?.reloadTableView()
                    self.checkFavorite()
                case .failure(let error):
                    print("DataNEWSRecomended RecomendedVC error \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - checkFavorite()
    private func checkFavorite(){ // вызвать в getRecomendedNews после получения data и уюрать релоад в getRecomendedNews после получении data
        let savedArticles: [Article] = user?.articles ?? [] // нужно заменить на сохраненные
        if !savedArticles.isEmpty{
            let savedArticleIds = savedArticles.map { $0.articleId }

            for (index,article) in data.enumerated() {
                if savedArticleIds.contains(article.articleId) {
                    data[index].isFavourite = true
                }
            }
        }
        view?.reloadTableView()
    }
    
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void) {
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
    
    func goToDetailVC(data: Article) {
        router?.goToDetailVC(data: data, user: self.user)
    }
    
    func dismisRecomendedVC(){
        router?.dismissVC()
    }
}
