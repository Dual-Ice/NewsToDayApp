//
//  MainBuilder.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import Foundation
import UIKit

protocol MainBuilderProtocol: AnyObject {
    
    func buildMainView() -> UIViewController
}

class MainBuilder: MainBuilderProtocol {
    
    let navigationVC = UINavigationController()
    
    func buildMainView() -> UIViewController {
        let vc = MainViewController()
        navigationVC.viewControllers = [vc]
        let router = MainRouter(navigationVC: navigationVC)
        let presenter = MainPresenter(view: vc, router: router)
        vc.presenter = presenter
        return vc
    }
}
