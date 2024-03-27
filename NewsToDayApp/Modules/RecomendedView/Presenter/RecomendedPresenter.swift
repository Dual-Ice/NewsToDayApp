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
    
    init(view: RecomendedPresenterViewProtocol, router: RecomendedRouterProtocol, newsManager: NewsManager, imageManager: ImageManager, searchWord: String?)
    var data: [Article] { get }
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
    func goToDetailVC(data: Article)
    func dismisRecomendedVC()
    func filterCategoriesArray(categories: [String]) -> [String]
}


class RecomendedPresenter: RecomendedPresenterProtocol {
    var data: [Article] = .init()
    
    weak var view: RecomendedPresenterViewProtocol?
    var router: RecomendedRouterProtocol?
    private let newsManager: NewsManager
    private let imageManager: ImageManager
    private let searchWord: String?
    
    private var arrayCatgories: [String] {
        ["science", "health"]
    }
    
    required init(view: RecomendedPresenterViewProtocol, router: RecomendedRouterProtocol, newsManager: NewsManager, imageManager: ImageManager, searchWord: String?) {
        self.view = view
        self.router = router
        self.newsManager = newsManager
        self.imageManager = imageManager
        self.searchWord = searchWord
        print("SEARCH WORD \(searchWord)")
        searchWord != nil ? getRecomendedNews(request: NewsRequest(query: searchWord)) : getRecomendedNews(request: NewsRequest(categories: arrayCatgories))
    }
    
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

    
    private func getRecomendedNews(request: NewsRequest){
        newsManager.getNews(with: request) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self.data = data.results ?? []
                    self.view?.reloadTableView()
                case .failure(let error):
                    print("DataNEWSRecomended RecomendedVC error \(error.localizedDescription)")
                }
            }
        }
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
    
    func goToDetailVC(data: Article){
        router?.goToDetailVC(data: data)
    }
    
    func dismisRecomendedVC(){
        router?.dismissVC()
    }
}
