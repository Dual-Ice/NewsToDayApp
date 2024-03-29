//
//  BooksmarksPresenter.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import UIKit

protocol BookmarksPresenterViewProtocol: AnyObject {
    func emptyBookmarks()
    func fullBookmarks()
    func reloadTableView()
    
}

protocol BookmarksPresenterProtocol: AnyObject {
    
    init(view: BookmarksPresenterViewProtocol,
         router: BookmarksRouter,
         imageManager: ImageManager
    )
    var data: [Article] { get }
    var imageCacheBookmarks: [IndexPath: UIImage] { get set }
    func checkBookmarks()
    func deleteArticle(articleId: String, completion: @escaping ( Error?) -> Void)
    func getAtriclesFromUser()
    func goToDetailVC(data: Article)
    func filterCategoriesArray(categories: [String]) -> [String]
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
}


class BookmarksPresenter: BookmarksPresenterProtocol {
    var data: [Article] = []
    
    var imageCacheBookmarks: [IndexPath: UIImage] = [:]
    
    weak var view: BookmarksPresenterViewProtocol?
    var router: BookmarksRouter?
    let imageManager: ImageManager
    
    private var arrayCategories: [String] = []
    
    required init(view: BookmarksPresenterViewProtocol, 
                  router: BookmarksRouter,
                  imageManager: ImageManager
    ) {
        self.view = view
        self.router = router
        self.imageManager = imageManager
    }
    
    // MARK: - Prepare CategoriesArray
    func filterCategoriesArray(categories: [String]) -> [String]{
        let translatedArray = categories.translateCategories(categoriesToTranslate: categories)
        let capitalizedCategories = translatedArray.capitalizingFirstLetterOfEachElement()
        let finalArray = capitalizedCategories.count > 2 ? Array(capitalizedCategories.prefix(2)) : capitalizedCategories
        return finalArray
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
    
    func checkBookmarks(){
        //проверяем базу данных если пустая вызываем emptyBookmarks() иначе fullBookmarks()
        UserManager.shared.getFavoriteArticles().isEmpty ?  view?.emptyBookmarks() : view?.fullBookmarks()
    }
    
    func deleteArticle(articleId: String, completion: @escaping ( Error?) -> Void){
        let newData = data.filter { $0.articleId != articleId }
        if newData.isEmpty{
            view?.emptyBookmarks()
        }
        UserManager.shared.deleteArticleFromFavorite(articleId: articleId) { error in
            completion(error)
        }
        getAtriclesFromUser()
    }
    
    func getAtriclesFromUser(){
        //записать в data значение из базы данных
        data = UserManager.shared.getFavoriteArticles()
        view?.reloadTableView()
    }
    
    func goToDetailVC(data: Article) {
        router?.goToDetailVC(data: data)
    }
}
