//
//  RecomendedBuilder.swift
//  NewsToDayApp
//
//  Created by Polina on 22.03.2024.
//

import UIKit

protocol RecomendedBuilderProtocol: AnyObject {
    
    func buildRecomendedVC() -> UIViewController
}

class RecomendedBuilder: RecomendedBuilderProtocol{
    func buildRecomendedVC() -> UIViewController {
        let vc = RecomendedViewController()
        let router = RecomendedRouter()
        let presenter = RecomendedPresenter(view: vc, router: router)
        vc.presenter = presenter
        return vc
    }
}
