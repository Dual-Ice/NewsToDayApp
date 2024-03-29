//
//  OnbordingPresenter.swift
//  NewsToDayApp
//
//  Created by Polina on 28.03.2024.
//


import Foundation
import UIKit
protocol OnbordingPresenterViewProtocol: AnyObject {
//    func checkAuth()
    func goToCategories()
    
}

protocol OnbordingPresenterProtocol: AnyObject {
    init( view: OnbordingPresenterViewProtocol, router: OnbordingRouterProtocol)
    var data: [OnbordingModel] { get }
    func goToCategoriesVC()
}

class OnbordingPresenter: OnbordingPresenterProtocol {
    
    private weak var view: OnbordingPresenterViewProtocol?
    private var router: OnbordingRouterProtocol?
    required init(
        view: OnbordingPresenterViewProtocol,
        router: OnbordingRouterProtocol)
    {
        self.view = view
        self.router = router
    }
    
    var data: [OnbordingModel] = OnbordingModel.getOnbordingModel()
    
    func goToCategoriesVC(){
        view?.goToCategories()
    }
    
}
