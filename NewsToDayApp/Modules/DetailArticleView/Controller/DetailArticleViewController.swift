//
//  DetailArticleViewController.swift
//  NewsToDayApp
//
//  Created by Polina on 20.03.2024.
//

import UIKit

class DetailArticleViewController: CustomViewController<DetailArticleView> {
    
    let data: OneItem
    let isLiked: Bool
    
    init(data: OneItem, isLiked: Bool) {
        self.data = data
        self.isLiked = isLiked
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        customView.configView(data: data, isLiked: isLiked)

    }
    
    private func setDelegates(){
        customView.delegate = self
    }

}

//MARK: - DetailArticleViewDelegate
extension DetailArticleViewController: DetailArticleViewDelegate {
    func tappedBackButton() {
        dismiss(animated: false)
    }
    
    func tappedFavoriteButton() {
        print("tappedFavoriteButton")
    }
    
    func tappedShareButton() {
        print("tappedShareButton")
    }
    
    
}

