//
//  CategoriesRouter.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//


import UIKit

protocol CategoriesRouterProtocol: AnyObject {
    init(navigationVC: UINavigationController)
}

class CategoriesRouter: CategoriesRouterProtocol {
    
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
}
