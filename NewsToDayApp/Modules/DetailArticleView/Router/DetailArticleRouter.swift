//
//  DetailArticlePresenter.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import UIKit

protocol DetailArticleRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    func dismissDetailVC()
    
}

class DetailArticleRouter: DetailArticleRouterProtocol {

    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func dismissDetailVC() {
        navigationVC?.popViewController(animated: true)
    }
}
