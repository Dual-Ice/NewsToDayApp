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
    
}

class MainRouter: MainRouterProtocol {
    
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
}
