//
//  LanguagesBuilder.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 22.03.2024.
//

import Foundation
import UIKit

protocol LanguagesBuilderProtocol: AnyObject {
    
    func buildLanguagesVC() -> UIViewController?
}

class LanguagesBuilder: LanguagesBuilderProtocol{
    weak var navigationVC: UINavigationController?
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildLanguagesVC() -> UIViewController? {
        guard let navigationVC = navigationVC else { return nil}
        let vc = LanguagesViewController()
        let router = LanguagesRouter(navigationVC: navigationVC)
        let presenter = LanguagesPresenter(view: vc, router: router)
        vc.presenter = presenter
        return vc
    }
}
