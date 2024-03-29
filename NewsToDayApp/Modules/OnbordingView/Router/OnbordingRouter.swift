//
//  OnbordingRouter.swift
//  NewsToDayApp
//
//  Created by Polina on 28.03.2024.
//


import UIKit

protocol OnbordingRouterProtocol: AnyObject {
    
   func goToCategoriesVC()
    var viewController: UIViewController? { get set }
    
}

class OnbordingRouter: OnbordingRouterProtocol {
    weak var viewController: UIViewController?
    
    
    func goToCategoriesVC() {
        //let categoriesVC = CategoriesBuilder().buildCategoriesView(user: user, type: .categoriesOnbording)
//        categoriesVC.modalPresentationStyle = .fullScreen
//        categoriesVC.modalTransitionStyle = .flipHorizontal
//        viewController.present(vc, animated: true)
    }
    
}
