//
//  CategoriesBuilder.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import UIKit
protocol CategoriesBuilderProtocol: AnyObject {
    
    func buildCategoriesView(mode: CategoriesViewMode) -> UIViewController
}

class CategoriesBuilder: CategoriesBuilderProtocol {

    func buildCategoriesView(mode: CategoriesViewMode) -> UIViewController {
        let vc = CategoriesViewController(mode: mode)
        let navigationController = UINavigationController(rootViewController: vc)
        let router = CategoriesRouter(navigationVC: navigationController)
        let presenter = CategoriesPresenter(
            view: vc,
            router: router
        )
        vc.presenter = presenter
        return navigationController
    }
}
