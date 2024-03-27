//
//  BookmarksRouter.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//


import UIKit

protocol BookmarksRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    func goToDetailVC(data: Article)
}

class BookmarksRouter: BookmarksRouterProtocol {
  
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func goToDetailVC(data: Article){
        guard let navigationVC else { return }
        let detailVC = DetailArticleBuilder(navigationVC: navigationVC).buildDetailArticleVC(data: data)
        guard let detailVC else { return }
        navigationVC.pushViewController(detailVC, animated: true)
    }
}
