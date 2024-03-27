//
//  MainBuilder.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import Foundation
import UIKit

protocol MainBuilderProtocol: AnyObject {
    
    func buildMainView(user: FirestoreUser?) -> UIViewController
}

class MainBuilder: MainBuilderProtocol {
    
    func buildMainView(user: FirestoreUser?) -> UIViewController {
        let vc = MainViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        let router = MainRouter(navigationVC: navigationController)
        let newsManager = NewsManager()
        let imageManager = ImageManager()
        let presenter = MainPresenter(
            view: vc,
            router: router,
            newsManager: newsManager,
            imageManager: imageManager,
            user: user
        )
        vc.presenter = presenter
        return navigationController
    }
}
