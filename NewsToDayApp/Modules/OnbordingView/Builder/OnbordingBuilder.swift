//
//  OnbordingBuilder.swift
//  NewsToDayApp
//
//  Created by Polina on 28.03.2024.
//

import Foundation
import UIKit
protocol OnbordingBuilderProtocol{
    func buildOnbordingVC() -> UIViewController
}

final class OnbordingBuilder: OnbordingBuilderProtocol{
    func buildOnbordingVC() -> UIViewController {
        let vc = OnbordingViewController()
        let router = OnbordingRouter()
        let presenter = OnbordingPresenter(view: vc, router: router)
        vc.presenter = presenter
        return vc
    }
    
    
}
