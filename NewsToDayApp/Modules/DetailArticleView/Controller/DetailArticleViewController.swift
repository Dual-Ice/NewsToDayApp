//
//  DetailArticleViewController.swift
//  NewsToDayApp
//
//  Created by Polina on 20.03.2024.
//

import UIKit

class DetailArticleViewController: CustomViewController<DetailArticleView> {
    
//    let data: OneItem
//    let isLiked: Bool
    var presenter: DetailArticlePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        customView.configView(data: presenter?.data , isLiked: presenter?.isLiked)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setDelegates(){
        customView.delegate = self
    }

}

//MARK: - DetailArticleViewDelegate
extension DetailArticleViewController: DetailArticleViewDelegate {
    func tappedBackButton() {
        presenter?.dismissDetailArticleVC()
    }
    
    func tappedFavoriteButton() {
        print("tappedFavoriteButton")
    }
    
    func tappedShareButton() {
        print("tappedShareButton")
    }
    
}

//MARK: - DetailArticlePresenterViewProtocol
extension DetailArticleViewController: DetailArticlePresenterViewProtocol {
    
}

