//
//  OnbordingPresenter.swift
//  NewsToDayApp
//
//  Created by Polina on 28.03.2024.
//


import Foundation
protocol OnbordingPresenterViewProtocol: AnyObject {
    
    
}

protocol OnbordingPresenterProtocol: AnyObject {
    init( view: OnbordingPresenterViewProtocol, router: OnbordingRouterProtocol)
    var data: [OnbordingModel] { get }
    func goToCategoriesVC()
}

class OnbordingPresenter: OnbordingPresenterProtocol {
    
    private weak var view: OnbordingPresenterViewProtocol?
    private var router: OnbordingRouterProtocol?
    required init(view: OnbordingPresenterViewProtocol,  router: OnbordingRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    var data: [OnbordingModel] = OnbordingModel.getOnbordingModel()
    
    func goToCategoriesVC(){
        router?.goToCategoriesVC()
    }
    
}
