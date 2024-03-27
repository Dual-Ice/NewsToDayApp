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
         data: Article,
         user: FirestoreUser?
    )
    var data: Article { get }
    func dismissDetailArticleVC()
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
    func saveToBookMarks()
    
}

class DetailArticlePresenter: DetailArticlePresenterProtocol {
    
    private weak var view: DetailArticlePresenterViewProtocol?
    private var router: DetailArticleRouterProtocol?
    let imageManager: ImageManager
    var data: Article
    var user: FirestoreUser?
    
    required init(view: DetailArticlePresenterViewProtocol,
                  router: DetailArticleRouterProtocol,
                  imageManager: ImageManager,
                  data: Article,
                  user: FirestoreUser?
    ) {
        self.data = data
        self.view = view
        self.router = router
        self.user = user
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
                case .failure(_):
                    completion(nil)
                }
            }
        })
    }
    
    func saveToBookMarks() {
        data.isFavourite = !(data.isFavourite)
        view?.changeBacgroundImageButton(isLiked: data.isFavourite)
        if data.isFavourite == true {
            //сохранить в закладки
            user?.articles.append(data)
        } else {
            //удалить из закладок если нажал на кнопку в ячейки повторно
            if let index = user?.articles.firstIndex(where: { $0.articleId == data.articleId }) {
                // Удаляем элемент из массива
                user?.articles.remove(at: index)
            }
        }
        FirestoreManager.shared.setCollection(
            with: user!
        ) { wasSet, error in
//                if let error = error {
//                    completion(false, error)
//                }
//                completion(true, nil)
        }
    }
}
