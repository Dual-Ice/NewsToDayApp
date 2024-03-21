//
//  BookmarksRouter.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//


import UIKit

protocol BookmarksRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    
}

class BookmarksRouter: BookmarksRouterProtocol {
  
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
}
