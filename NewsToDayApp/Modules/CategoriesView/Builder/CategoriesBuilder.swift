//
//  CategoriesBuilder.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import UIKit
protocol CategoriesBuilderProtocol: AnyObject {
    
    func buildCategoriesView() -> UIViewController
}

class CategoriesBuilder: CategoriesBuilderProtocol {

    func buildCategoriesView() -> UIViewController {
        let vc = CategoriesViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        let router = CategoriesRouter(navigationVC: navigationController)
        let presenter = CategoriesPresenter(view: vc, router: router)
        vc.presenter = presenter
        vc.typeToHideButtonOrNot = .categoriesInTabBar // спрятать next button или нет 
        return navigationController
    }
}
