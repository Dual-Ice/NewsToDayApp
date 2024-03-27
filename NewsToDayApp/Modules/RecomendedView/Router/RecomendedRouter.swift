//
//  RecomendedRouter.swift
//  NewsToDayApp
//
//  Created by Polina on 22.03.2024.
//


import UIKit

protocol RecomendedRouterProtocol: AnyObject {
    init(navigationVC: UINavigationController)
    func goToDetailVC(data: Article, user: FirestoreUser?)
    func dismissVC()
    
}

class RecomendedRouter: RecomendedRouterProtocol {
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func goToDetailVC(data: Article, user: FirestoreUser?){
        guard let navigationVC else { return }
        let detailVC = DetailArticleBuilder(navigationVC: navigationVC).buildDetailArticleVC(data: data, user: user)
        guard let detailVC else { return }
        navigationVC.pushViewController(detailVC, animated: true)
    }
    
    func dismissVC(){
        guard let navigationVC else { return }
        navigationVC.popViewController(animated: true)
    }
}
