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
        presenter?.loadImage(imageUrl: presenter?.data?.imageUrl, completion: { image in
            let imageToUse = image ?? UIImage(named: "noImage")
            self.customView.configView(data: self.presenter?.data , isLiked: self.presenter?.isLiked, image: imageToUse)
            
        })
        customView.configView(data: presenter?.data , isLiked: presenter?.isLiked, image: nil)

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

