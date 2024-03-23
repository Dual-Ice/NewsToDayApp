//
//  LanguagesPresenter.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 22.03.2024.
//

import Foundation
import UIKit

protocol LanguagesRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    func dismissLanguagesVC()
    
}

class LanguagesRouter: LanguagesRouterProtocol {
  
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func dismissLanguagesVC() {
        navigationVC?.popViewController(animated: true)
    }
    
}
