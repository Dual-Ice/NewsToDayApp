//
//  CategoriesPresenter.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import Foundation
import UIKit

protocol CategoriesPresenterViewProtocol: AnyObject {
    
}

protocol CategoriesPresenterProtocol: AnyObject {
    init(view: CategoriesPresenterViewProtocol,
         router: CategoriesRouterProtocol,
         user: FirestoreUser?
    )
    var data: [CategoriesModel] { get }
    var selectedIndexPathArray: [IndexPath] { get }
    func saveSelectedCell(indexPath: IndexPath, category: String)
    func removeUnSelectedCell(indexPath: IndexPath, category: String)
    func saveCategoriesArray(completion: @escaping (Bool, Error?) -> Void)
    func tappedNextButton()
    
}


class CategoriesPresenter: CategoriesPresenterProtocol {
    var selectedIndexPathArray: [IndexPath] = .init()
    
    var user: FirestoreUser?
    
    private var categoriesArray: [String] = .init()
    
    var data: [CategoriesModel] = CategoriesModel.allCases
    
    private weak var view: CategoriesPresenterViewProtocol?
    private var router: CategoriesRouterProtocol?
    
    required init(view: CategoriesPresenterViewProtocol,
                  router: CategoriesRouterProtocol,
                  user: FirestoreUser?) {
        self.view = view
        self.router = router
        self.user = user
        setSelectedColorForOnbordingSelection(selectedCategories: user?.categories ?? [])
    }
    
    private func setSelectedColorForOnbordingSelection(selectedCategories: [String]){
        let indexes = selectedCategories.compactMap { categoryValue in
            data.firstIndex(where: { $0.categoryValue == categoryValue })
        }
        let indexPaths = indexes.map { IndexPath(item: $0, section: 0) }
        categoriesArray = selectedCategories
        selectedIndexPathArray = indexPaths
    }
    
    func saveSelectedCell(indexPath: IndexPath, category: String) {
        selectedIndexPathArray.append(indexPath)
        categoriesArray.append(category)
       // print("categortArray1 \(categoriesArray)")
    }
    
    func removeUnSelectedCell(indexPath: IndexPath, category: String) {
        let indexToRemove = selectedIndexPathArray.firstIndex(where: { $0 == indexPath })
        if let indexToRemove{
            selectedIndexPathArray.remove(at: indexToRemove)
            categoriesArray.remove(at: indexToRemove)
           // print("categortArray2 \(categoriesArray)")
        }
    }
    
    func saveCategoriesArray(completion: @escaping (Bool, Error?) -> Void){
        print("categoriesArray saved\(categoriesArray)")
        user?.categories = categoriesArray
        FirestoreManager.shared.setCollection(
            with: user!
        ) { wasSet, error in
            if let error = error {
                completion(false, error)
            }
            completion(true, nil)
        }
        // categoriesArray сохранить, если отличается от уже сохраненного и не пустой
    }
    
    func tappedNextButton() {
        if categoriesArray.isEmpty{
            print("Please select category")
        } else {
            router?.customTabBar = view as? UIViewController
            router?.goToCustomTabBar()
            print("go next screen")
        }
        // нажали Next на onbording
    }
}
