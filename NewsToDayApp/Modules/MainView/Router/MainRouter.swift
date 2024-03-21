//
//  MainRouter.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import Foundation
import UIKit

protocol MainRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    func pushDetailVC(data: OneItem, isLiked: Bool)
    
}

class MainRouter: MainRouterProtocol {
  
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func pushDetailVC(data: OneItem, isLiked: Bool) {
        let detailVC = DetailArticleViewController(data: data, isLiked: isLiked)
        navigationVC?.pushViewController(detailVC, animated: true)
    }
}
