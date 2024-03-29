//
//  DetailArticlePresenter.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import UIKit


protocol DetailArticlePresenterViewProtocol: AnyObject {
    func changeBacgroundImageButton(isLiked: Bool)
    
}

protocol DetailArticlePresenterProtocol: AnyObject {
    init(view: DetailArticlePresenterViewProtocol,
         router: DetailArticleRouterProtocol,
         imageManager: ImageManager,
         data: Article
    )
    var data: Article { get }
    func dismissDetailArticleVC()
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
    func saveToBookMarks(completion: @escaping (Error?) -> Void)
    func checkFavorite()
}

class DetailArticlePresenter: DetailArticlePresenterProtocol {
    
    private weak var view: DetailArticlePresenterViewProtocol?
    private var router: DetailArticleRouterProtocol?
    let imageManager: ImageManager
    var data: Article
    
    required init(view: DetailArticlePresenterViewProtocol,
                  router: DetailArticleRouterProtocol,
                  imageManager: ImageManager,
                  data: Article
    ) {
        self.data = data
        self.view = view
        self.router = router
        self.imageManager = imageManager
    }
    
    func dismissDetailArticleVC(){
        router?.dismissDetailVC()
    }
    
    func checkFavorite(){
        let savedArticles: [Article] = UserManager.shared.getFavoriteArticles()
        let savedArticleIds = savedArticles.map { $0.articleId }
        
        if savedArticleIds.contains(data.articleId) {
            data.isFavourite = true
        } else {
            data.isFavourite = false
        }
        view?.changeBacgroundImageButton(isLiked: data.isFavourite)
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
    
    func saveToBookMarks(completion: @escaping (Error?) -> Void) {
        data.isFavourite = !(data.isFavourite)
        view?.changeBacgroundImageButton(isLiked: data.isFavourite)
        if data.isFavourite == true {
            UserManager.shared.addArticleFavorite(article: data) { error in
                completion(error)
            }
        } else {
            UserManager.shared.deleteArticleFromFavorite(articleId: data.articleId) { error in
                completion(error)
            }
        }
    }
}
