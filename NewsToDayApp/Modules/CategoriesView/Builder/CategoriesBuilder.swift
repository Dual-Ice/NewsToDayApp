//
//  CategoriesBuilder.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import UIKit
protocol CategoriesBuilderProtocol: AnyObject {
    
    func buildCategoriesView(type: HideButtonOnCategoriesView) -> UIViewController
}

class CategoriesBuilder: CategoriesBuilderProtocol {

    func buildCategoriesView(type: HideButtonOnCategoriesView) -> UIViewController {
        let vc = CategoriesViewController(typeToHideButtonOrNot: type)
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
