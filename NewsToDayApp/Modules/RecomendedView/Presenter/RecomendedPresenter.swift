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
    
    init(view: RecomendedPresenterViewProtocol, router: RecomendedRouterProtocol, newsManager: NewsManager, imageManager: ImageManager)
    var data: [Article] { get }
    func getRecomendedNews(categoryArray: [String])
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
    func goToDetailVC(data: Article?, isLiked: Bool)
}


class RecomendedPresenter: RecomendedPresenterProtocol {
    var data: [Article] = .init()
    
    weak var view: RecomendedPresenterViewProtocol?
    var router: RecomendedRouterProtocol?
    private let newsManager: NewsManager
    private let imageManager: ImageManager
    
    required init(view: RecomendedPresenterViewProtocol, router: RecomendedRouterProtocol, newsManager: NewsManager, imageManager: ImageManager) {
        self.view = view
        self.router = router
        self.newsManager = newsManager
        self.imageManager = imageManager
    }
    
    func getRecomendedNews(categoryArray: [String]){
        let request = NewsRequest(categories: categoryArray)
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
}
