//
//  ProfileBuilder.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit

protocol ProfileBuilderProtocol: AnyObject {
    
    func buildProfileView() -> UIViewController
    init(navigationVC: UINavigationController)
    
}

class ProfileBuilder: ProfileBuilderProtocol {
    
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildProfileView() -> UIViewController {
        
        guard let navigationVC = navigationVC else {
            fatalError("ProfileBuilder requires a valid navigationController")
        }
        let vc = ProfileViewController()
        let router = ProfileRouter(navigationVC: navigationVC)
        let presenter = ProfilePresenter(view: vc, router: router)
        
        vc.presenter = presenter
        
        return vc
    }
}
