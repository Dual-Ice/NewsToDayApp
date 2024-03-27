//
//  ProfileBuilder.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit

protocol ProfileBuilderProtocol: AnyObject {
    
    func buildProfileView(user: FirestoreUser?) -> UIViewController
    
}

class ProfileBuilder: ProfileBuilderProtocol {

    func buildProfileView(user: FirestoreUser?) -> UIViewController {
        let vc = ProfileViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        let router = ProfileRouter(navigationVC: navigationController)
        let presenter = ProfilePresenter(
            view: vc,
            router: router,
            user: user
        )
        vc.presenter = presenter
        return navigationController
    }
}
