//
//  RecomendedBuilder.swift
//  NewsToDayApp
//
//  Created by Polina on 22.03.2024.
//

import UIKit

protocol RecomendedBuilderProtocol: AnyObject {
    
    func buildRecomendedVC(user: FirestoreUser?, searchWord: String?) -> UIViewController?
}

class RecomendedBuilder: RecomendedBuilderProtocol{
    weak var navigationVC: UINavigationController?
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildRecomendedVC(user: FirestoreUser?, searchWord: String?) -> UIViewController? {
       guard let navigationVC = navigationVC else { return nil}
        let vc = RecomendedViewController()
        let router = RecomendedRouter(navigationVC: navigationVC)
        let newsManager = NewsManager()
        let imageManager = ImageManager()
        let presenter = RecomendedPresenter(
            view: vc,
            router: router,
            newsManager: newsManager,
            imageManager: imageManager,
            user: user,
            searchWord: searchWord
        )
        vc.presenter = presenter
        return vc
    }
    
//    func buildDetailArticleVC(data: Article?, isLiked: Bool) -> UIViewController? {
//        guard let navigationVC = navigationVC else { return nil}
//        let vc = DetailArticleViewController()
//        let router = DetailArticleRouter(navigationVC: navigationVC)
//        let imageManager = ImageManager()
//        let presenter = DetailArticlePresenter(view: vc, router: router, imageManager: imageManager, data: data, isLiked: isLiked)
//        vc.presenter = presenter
//        return vc
//    }
}
