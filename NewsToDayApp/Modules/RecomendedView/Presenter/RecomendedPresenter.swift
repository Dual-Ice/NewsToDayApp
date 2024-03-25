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
    func goToDetailVC(data: Article?, isLiked: Bool)
    func dismisRecomendedVC()
}


class RecomendedPresenter: RecomendedPresenterProtocol {
    var data: [Article] = .init()
    
    weak var view: RecomendedPresenterViewProtocol?
    var router: RecomendedRouterProtocol?
    private let newsManager: NewsManager
    private let imageManager: ImageManager
    private let searchWord: String?
    required init(view: RecomendedPresenterViewProtocol, router: RecomendedRouterProtocol, newsManager: NewsManager, imageManager: ImageManager, searchWord: String?) {
        self.view = view
        self.router = router
        self.newsManager = newsManager
        self.imageManager = imageManager
        self.searchWord = searchWord
        print("SEARCH WORD \(searchWord)")
        searchWord != nil ? getRecomendedNews(request: NewsRequest(query: searchWord)) : getRecomendedNews(request: NewsRequest(categories: ["Science", "Health"]))
        
    }
    
    private func getRecomendedNews(request: NewsRequest){
        newsManager.getNews(with: request) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    print("DataNEWSRecomended RecomendedVC \(data)")
                    self.data = data.results ?? []
                    self.view?.reloadTableView()
                case .failure(let error):
                    print("DataNEWSRecomended error \(error.localizedDescription)")
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
                case .failure(let error):
                    print(" error downloadImage RecimmendedVC \(error.localizedDescription)")
                    completion(nil)
                }
            }
        })
    }
    
    func goToDetailVC(data: Article?, isLiked: Bool){
        router?.goToDetailVC(data: data, isLiked: isLiked)
    }
    
    func dismisRecomendedVC(){
        router?.dismissVC()
    }
}
