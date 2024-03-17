//
//  ProfileRouter.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import Foundation
import UIKit

protocol ProfileRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    
}

class ProfileRouter: ProfileRouterProtocol {
    
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
}
