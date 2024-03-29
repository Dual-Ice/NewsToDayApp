//
//  CategoriesPresenter.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import Foundation
import UIKit

protocol CategoriesPresenterViewProtocol: AnyObject {
    func checkAuthOrNot()
    func reloadCollectionView()
}

protocol CategoriesPresenterProtocol: AnyObject {
    init(view: CategoriesPresenterViewProtocol,
         router: CategoriesRouterProtocol
    )
    var data: [CategoriesModel] { get }
    var selectedIndexPathArray: [IndexPath] { get }
    func saveSelectedCell(indexPath: IndexPath, category: String)
    func removeUnSelectedCell(indexPath: IndexPath, category: String)
    func saveCategoriesArray(completion: @escaping (Error?) -> Void)
    func tappedNextButton()
    func setSelectedColorForOnbordingSelection(selectedCategories: [String])
    
}


class CategoriesPresenter: CategoriesPresenterProtocol {
    var selectedIndexPathArray: [IndexPath] = .init()
    
    private var categoriesArray: [String] = .init()
    
    var data: [CategoriesModel] = CategoriesModel.allCases
    
    private weak var view: CategoriesPresenterViewProtocol?
    private var router: CategoriesRouterProtocol?
    
    required init(view: CategoriesPresenterViewProtocol,
                  router: CategoriesRouterProtocol) {
        self.view = view
        self.router = router
//        setSelectedColorForOnbordingSelection(selectedCategories: UserManager.shared.getCategories())
    }
    
    func setSelectedColorForOnbordingSelection(selectedCategories: [String]){
        let indexes = selectedCategories.compactMap { categoryValue in
            data.firstIndex(where: { $0.categoryValue == categoryValue })
        }
        let indexPaths = indexes.map { IndexPath(item: $0, section: 0) }
        categoriesArray = selectedCategories
        print("CategoriesVC selected \(categoriesArray)")
        selectedIndexPathArray = indexPaths
        view?.reloadCollectionView()
    }
    
    func saveSelectedCell(indexPath: IndexPath, category: String) {
        selectedIndexPathArray.append(indexPath)
        categoriesArray.append(category)
    }
    
    func removeUnSelectedCell(indexPath: IndexPath, category: String) {
        let indexToRemove = selectedIndexPathArray.firstIndex(where: { $0 == indexPath })
        if let indexToRemove{
            selectedIndexPathArray.remove(at: indexToRemove)
            categoriesArray.remove(at: indexToRemove)
        }
    }
    
    func saveCategoriesArray(completion: @escaping ( Error?) -> Void){
        print("categoriesArray saved\(categoriesArray)")
        UserManager.shared.updateCategories(categories: categoriesArray) { error in
            if let error = error {
                completion(error)
            }
        }
    }
    
    func tappedNextButton() {
        if categoriesArray.isEmpty{
            print("Please select category")
        } else {
            UserDefaults.standard.set(true, forKey: "isOnboardingCompleted")
            self.view?.checkAuthOrNot()
        }
    }
}
