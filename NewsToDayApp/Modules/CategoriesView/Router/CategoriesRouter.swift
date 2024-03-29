//
//  CategoriesRouter.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//


import UIKit

protocol CategoriesRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    var customTabBar: UIViewController? {get set}
    func goToCustomTabBar()
    
}

class CategoriesRouter: CategoriesRouterProtocol {
    
    weak var navigationVC: UINavigationController?
    weak var customTabBar: UIViewController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func goToCustomTabBar(){
        
    }
    
}
