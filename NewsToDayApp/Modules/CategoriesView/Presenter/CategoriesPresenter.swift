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
    
    init(view: CategoriesPresenterViewProtocol, router: CategoriesRouterProtocol)
    var data: [CategoriesModel] { get }
    var selectedIndexPathArray: [IndexPath] { get }
    func saveSelectedCell(indexPath: IndexPath, category: String)
    func removeUnSelectedCell(indexPath: IndexPath, category: String)
    
}


class CategoriesPresenter: CategoriesPresenterProtocol {
    var selectedIndexPathArray: [IndexPath] = .init()
    
    private var categoriesArray: [String] = .init()
    
    var data: [CategoriesModel] = CategoriesModel.getAllCategories()
    
    weak var view: CategoriesPresenterViewProtocol?
    var router: CategoriesRouterProtocol?
    
    required init(view: CategoriesPresenterViewProtocol, router: CategoriesRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func saveSelectedCell(indexPath: IndexPath, category: String) {
        selectedIndexPathArray.append(indexPath)
        categoriesArray.append(category)
        print("categortArray1 \(categoriesArray)")
    }
    
    func removeUnSelectedCell(indexPath: IndexPath, category: String) {
        let indexToRemove = selectedIndexPathArray.firstIndex(where: { $0 == indexPath })
        if let indexToRemove{
            selectedIndexPathArray.remove(at: indexToRemove)
            categoriesArray.remove(at: indexToRemove)
            print("categortArray2 \(categoriesArray)")
        }
        //selectedIndexPathArray.remove(at: indexToRemove)
//        for (index, item) in selectedIndexPathArray.enumerated(){
//            if item == indexPath{
//                selectedIndexPathArray.remove(at: index)
//                //print(" array3 \(selectedIndexPathArray)")
//            }
//        }
    }
}
