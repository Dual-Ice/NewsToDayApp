//
//  BookmarksBuilder.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import UIKit
protocol BookmarksBuilderProtocol: AnyObject {
    
    func buildBookmarksView() -> UIViewController
}

class BookmarksBuilder: BookmarksBuilderProtocol {
 
    let navigationVC = UINavigationController()
    
    func buildBookmarksView() -> UIViewController {
        let vc = BookmarksViewController()
        navigationVC.viewControllers = [vc]
        let router = BookmarksRouter(navigationVC: navigationVC)
        let presenter = BookmarksPresenter(view: vc, router: router)
        vc.presenter = presenter
        return vc
    }
}
