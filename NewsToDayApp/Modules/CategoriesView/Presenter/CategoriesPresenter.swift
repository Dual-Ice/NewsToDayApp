//
//  CategoriesPresenter.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import Foundation

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
    func saveCategoriesArray()
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
        setSelectedColorForOnbordingSelection(selectedCategories: ["sports"])
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
    
    func saveCategoriesArray(){
        print("categoriesArray saved\(categoriesArray)")
        // categoriesArray сохранить, если отличается от уже сохраненного и не пустой
    }
    
    func tappedNextButton() {
        // нажали Next на onbording
    }
}
