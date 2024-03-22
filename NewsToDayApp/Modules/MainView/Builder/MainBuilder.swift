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
    
    func buildMainView() -> UIViewController {
        let vc = MainViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        let router = MainRouter(navigationVC: navigationController)
        let presenter = MainPresenter(view: vc, router: router)
        vc.presenter = presenter
        return navigationController
    }
}
