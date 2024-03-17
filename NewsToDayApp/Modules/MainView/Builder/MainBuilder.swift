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
    init(navigationVC: UINavigationController)
    
}

class MainBuilder: MainBuilderProtocol {
    
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildMainView() -> UIViewController {
        
        guard let navigationVC = navigationVC else {
            fatalError("MainBuilder requires a valid navigationController")
        }
        let vc = MainViewController()
        let router = MainRouter(navigationVC: navigationVC)
        let presenter = MainPresenter(view: vc, router: router)
        
        vc.presenter = presenter
        
        return vc
    }
}
