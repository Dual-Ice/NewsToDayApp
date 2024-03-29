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
         imageManager: ImageManager,
         user: FirestoreUser?
    )
    var data: [Article] { get }
    var imageCacheBookmarks: [IndexPath: UIImage] { get set }
    func checkBookmarks()
    func deleteOneArticle(articleId: String)
    func getSaveAtricles()
    func goToDetailVC(data: Article)
    func filterCategoriesArray(categories: [String]) -> [String]
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
}


class BookmarksPresenter: BookmarksPresenterProtocol {
    var data: [Article] = []
    
    var user: FirestoreUser?
    var imageCacheBookmarks: [IndexPath: UIImage] = [:]
    
    weak var view: BookmarksPresenterViewProtocol?
    var router: BookmarksRouter?
    let imageManager: ImageManager
    
    private var arrayCategories: [String] = []
    
    required init(view: BookmarksPresenterViewProtocol, 
                  router: BookmarksRouter,
                  imageManager: ImageManager,
                  user: FirestoreUser?
    ) {
        self.view = view
        self.router = router
        self.imageManager = imageManager
        self.user = user
    }
    
    // MARK: - Prepare CategoriesArray
    func filterCategoriesArray(categories: [String]) -> [String]{
        let translatedArray = categories.translateCategories(filteredCategory: categories)
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
         data.isEmpty ? view?.emptyBookmarks() : view?.fullBookmarks()//проверяем базу данных если пустая вызываем emptyBookmarks() иначе fullBookmarks()
        
    }
    
    func deleteOneArticle(articleId: String){
        data = data.filter { $0.articleId != articleId } //удаляем из data
        // удалить из базы данных
        // обновить data для этого вызвать getSaveAtricles()
        if let index = user?.articles.firstIndex(where: { $0.articleId == articleId }) {
            user?.articles.remove(at: index)
        }
    
        FirestoreManager.shared.setCollection(
            with: user!
        ) { wasSet, error in
        //                if let error = error {
        //                    completion(false, error)
        //                }
        //                completion(true, nil)
        }
         view?.reloadTableView()
    }
    
    func getSaveAtricles(){
        //записать в data значение из базы данных
        data = user?.articles ?? []
        view?.reloadTableView()
    }
    
    func goToDetailVC(data: Article) {
        router?.goToDetailVC(data: data, user: self.user)
    }
}
