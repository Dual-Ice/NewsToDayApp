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
    func pushDetailVC(data: Article?, isLiked: Bool)
    func pushRecomendedView()
    func pushSearchByWordScreen(searchWord: String)
}

class MainRouter: MainRouterProtocol {
  
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func pushDetailVC(data: Article?, isLiked: Bool) {
        guard let navigationVC = navigationVC else { return }
        let detailVC = DetailArticleBuilder(navigationVC: navigationVC).buildDetailArticleVC(data: data, isLiked: isLiked)
        guard let detailVC = detailVC else { return }
        navigationVC.pushViewController(detailVC, animated: true)
    }
    
    func pushRecomendedView(){
        guard let navigationVC = navigationVC else { return }
        let recomendedVC = RecomendedBuilder(navigationVC: navigationVC).buildRecomendedVC(searchWord: nil)
        guard let recomendedVC else { return }
        navigationVC.pushViewController(recomendedVC, animated: true)
    }
    
    func pushSearchByWordScreen(searchWord: String){
        guard let navigationVC = navigationVC else { return }
        let serachByWordVC = RecomendedBuilder(navigationVC: navigationVC).buildRecomendedVC(searchWord: searchWord)
        guard let serachByWordVC else { return }
        navigationVC.pushViewController(serachByWordVC, animated: true)
    }
}
