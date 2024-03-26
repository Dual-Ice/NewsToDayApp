//
//  TermsAndConditionsBuilder.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 22.03.2024.
//

import Foundation
import UIKit

protocol TermsAndConditionsBuilderProtocol: AnyObject {
    
    func buildTermsAndConditionsVC() -> UIViewController?
}

class TermsAndConditionsBuilder: TermsAndConditionsBuilderProtocol {
    
    weak var navigationVC: UINavigationController?
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildTermsAndConditionsVC() -> UIViewController? {
        guard let navigationVC = navigationVC else { return nil}
        let vc = TermsAndConditionsViewController()
        let router = TermsAndConditionsRouter(navigationVC: navigationVC)
        let presenter = TermsAndConditionsPresenter(view: vc, router: router)
        vc.presenter = presenter
        return vc
    }
}
