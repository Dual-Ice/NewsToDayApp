//
//  ProfileBuilder.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit

protocol ProfileBuilderProtocol: AnyObject {
    
    func buildProfileView() -> UIViewController
    
}

class ProfileBuilder: ProfileBuilderProtocol {
    
    let navigationVC = UINavigationController()
    
    
    func buildProfileView() -> UIViewController {
        
        let vc = ProfileViewController()
        navigationVC.setViewControllers([vc], animated: true)
        let router = ProfileRouter(navigationVC: navigationVC)
        let presenter = ProfilePresenter(view: vc, router: router)
        
        vc.presenter = presenter
        
        return vc
    }
}
