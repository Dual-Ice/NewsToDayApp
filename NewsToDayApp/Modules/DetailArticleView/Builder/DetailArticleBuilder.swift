//
//  DetailArticleBuilder.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import Foundation
import UIKit

protocol DetailBuilderProtocol: AnyObject {
    
    func buildDetailArticleVC(data: Article?, isLiked: Bool) -> UIViewController?
}

class DetailArticleBuilder: DetailBuilderProtocol{
    weak var navigationVC: UINavigationController?
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildDetailArticleVC(data: Article?, isLiked: Bool) -> UIViewController? {
        guard let navigationVC = navigationVC else { return nil}
        let vc = DetailArticleViewController()
        let router = DetailArticleRouter(navigationVC: navigationVC)
        let imageManager = ImageManager()
        let presenter = DetailArticlePresenter(view: vc, router: router, imageManager: imageManager, data: data, isLiked: isLiked)
        vc.presenter = presenter
        return vc
    }
}
