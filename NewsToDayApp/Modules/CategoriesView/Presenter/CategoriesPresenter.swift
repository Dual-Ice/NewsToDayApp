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
    
    init(view: CategoriesPresenterViewProtocol, router: CategoriesRouterProtocol)
    var data: [OneItem] { get }
    var selectedIndexPathArray: [IndexPath] { get }
    func saveSelectedCell(indexPath: IndexPath)
    func removeUnSelectedCell(indexPath: IndexPath)
    
}


class CategoriesPresenter: CategoriesPresenterProtocol {
    var selectedIndexPathArray: [IndexPath] = .init()
    
    var data: [OneItem] = MockDataModel.getCategoriesModel()
    
    weak var view: CategoriesPresenterViewProtocol?
    var router: CategoriesRouterProtocol?
    
    required init(view: CategoriesPresenterViewProtocol, router: CategoriesRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func saveSelectedCell(indexPath: IndexPath) {
        selectedIndexPathArray.append(indexPath)
    }
    
    func removeUnSelectedCell(indexPath: IndexPath) {
        let indexToRemove = selectedIndexPathArray.firstIndex(where: { $0 == indexPath })
        if let indexToRemove{
            selectedIndexPathArray.remove(at: indexToRemove)
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
