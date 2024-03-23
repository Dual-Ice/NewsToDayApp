//
//  TermsAndConditionsPresenter.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 22.03.2024.
//

import Foundation
import UIKit

protocol TermsAndConditionsRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    func dismissTermsAndConditionsVC()
    
}

class TermsAndConditionsRouter: TermsAndConditionsRouterProtocol {

    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func dismissTermsAndConditionsVC() {
        navigationVC?.popViewController(animated: true)
    }
    
}
