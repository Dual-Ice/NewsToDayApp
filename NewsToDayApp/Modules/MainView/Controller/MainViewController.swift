//
//  MainViewController.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit

class MainViewController: CustomViewController<MainView> {
    
    private var mockData: [ListSectionModel]{
        let data1 = MockDataModel.getCategoriesModel()
        let data2 = MockDataModel.getArticleModel()
        let data3 = MockDataModel.getArticleModel()
        return   [.categories(data1), .corusel(data2), .recomendations(data3)]
    }
    
    var presenter: MainPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setDelegates(){
        customView.delegate = self
    }
    
    
    
}

extension MainViewController: MainViewProtocol {
    
}

extension MainViewController: MainViewDelegate{
    func tappedSeeAllButton() {
        print("Tapped SeeAll")
    }
    
    func tappedFavoriteButton() {
        print("Tapped Favorite")
    }
    
    func getSections() -> Int {
        mockData.count
    }
}



