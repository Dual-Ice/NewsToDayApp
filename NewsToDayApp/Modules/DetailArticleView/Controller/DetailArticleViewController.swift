//
//  DetailArticleViewController.swift
//  NewsToDayApp
//
//  Created by Polina on 20.03.2024.
//

import UIKit

protocol DetailArticleVCDelegate{
    func changeBacgroundImageButton(isLiked: Bool)
}

class DetailArticleViewController: CustomViewController<DetailArticleView> {

    var presenter: DetailArticlePresenterProtocol?
    var detailView: DetailArticleVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        configView()
    }
    
    private func configView(){
        presenter?.loadImage(imageUrl: presenter?.data.imageUrl, completion: { [weak self] image in
            guard let self else { return }
            let imageToUse = image ?? UIImage.Images.noImage
            self.customView.configView(data: self.presenter?.data , isLiked: self.presenter?.data.isFavourite, image: imageToUse)
            
        })
        customView.configView(data: presenter?.data , isLiked: self.presenter?.data.isFavourite, image: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setDelegates(){
        customView.delegate = self
        detailView = customView
    }

}

//MARK: - DetailArticleViewDelegate
extension DetailArticleViewController: DetailArticleViewDelegate {
    func tappedBackButton() {
        presenter?.dismissDetailArticleVC()
    }
    
    func tappedFavoriteButton() {
        presenter?.saveToBookMarks() { error in
            if error != nil {
                print("Error is occured during switching article favorite property")
            }
        }
    }
    
    func tappedShareButton() {
        print("tappedShareButton")
    }
    
}

//MARK: - DetailArticlePresenterViewProtocol
extension DetailArticleViewController: DetailArticlePresenterViewProtocol {
    func changeBacgroundImageButton(isLiked: Bool) {
        detailView?.changeBacgroundImageButton(isLiked: isLiked)
    }
}

