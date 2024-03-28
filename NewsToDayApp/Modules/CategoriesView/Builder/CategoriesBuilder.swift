//
//  CategoriesBuilder.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import UIKit
protocol CategoriesBuilderProtocol: AnyObject {
    
    func buildCategoriesView(user: FirestoreUser?, type: HideButtonOnCategoriesView) -> UIViewController
}

class CategoriesBuilder: CategoriesBuilderProtocol {

    func buildCategoriesView(user: FirestoreUser?, type: HideButtonOnCategoriesView) -> UIViewController {
        let vc = CategoriesViewController(typeToHideButtonOrNot: type)
        let navigationController = UINavigationController(rootViewController: vc)
        let router = CategoriesRouter(navigationVC: navigationController)
        let presenter = CategoriesPresenter(
            view: vc,
            router: router,
            user: user
        )
        vc.presenter = presenter
        return navigationController
    }
}
