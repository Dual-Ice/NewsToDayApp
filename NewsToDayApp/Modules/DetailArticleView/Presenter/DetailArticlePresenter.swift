//
//  DetailArticlePresenter.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import UIKit


protocol DetailArticlePresenterViewProtocol: AnyObject {
    
    
}

protocol DetailArticlePresenterProtocol: AnyObject {
    
    init( view: DetailArticlePresenterViewProtocol, router: DetailArticleRouterProtocol, imageManager: ImageManager,  data: Article?, isLiked: Bool)
    var data: Article? { get }
    var isLiked: Bool { get }
    func dismissDetailArticleVC()
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
    
}


class DetailArticlePresenter: DetailArticlePresenterProtocol {
   
    weak var view: DetailArticlePresenterViewProtocol?
    var router: DetailArticleRouterProtocol?
    let imageManager: ImageManager
    var data: Article?
    var isLiked: Bool
    
    required init(view: DetailArticlePresenterViewProtocol, router: DetailArticleRouterProtocol, imageManager: ImageManager, data: Article?, isLiked: Bool ) {
        self.data = data
        self.isLiked = isLiked
        self.view = view
        self.router = router
        self.imageManager = imageManager
    }
    
    func dismissDetailArticleVC(){
        router?.dismissDetailVC()
    }
    
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void) {
        imageManager.getImage(for: imageUrl, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    completion(image)
                case .failure(let error):
                    print(" error downloadImage DetailVC \(error.localizedDescription)")
                    completion(nil)
                }
            }
        })
    }
}
