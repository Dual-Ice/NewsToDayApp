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
    func pushLanguagesVC()
    func pushTermsAndConditionsVC()
    
}

class ProfileRouter: ProfileRouterProtocol {
    
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func pushLanguagesVC(){
        guard let navigationVC = navigationVC else { return }
        let languagesVC = LanguagesBuilder(navigationVC: navigationVC).buildLanguagesVC()
        navigationVC.pushViewController(languagesVC!, animated: true)
    }
    func pushTermsAndConditionsVC(){
        guard let navigationVC = navigationVC else { return }
        let termsAndConditionsVC = TermsAndConditionsBuilder(navigationVC: navigationVC).buildTermsAndConditionsVC()
        navigationVC.pushViewController(termsAndConditionsVC!, animated: true)
    }
    
}
