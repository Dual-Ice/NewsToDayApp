//
//  ArticleCouruselCell.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//

import UIKit
import SnapKit

class ArticleCouruselCell: UICollectionViewCell {
    static let resuseID = "ArticleCouruselCell"
    
    private let categoryLabel = LabelsFactory.makeCategoryLabel()
    private let articleNameLabel = LabelsFactory.makeArticleHeaderLabel()
    private let backImage = ImageViewFactory.makeCornerRadiusImage()
    private let favoriteButton = ButtonsFactory.makeButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setViews()
        layoutViews()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
        articleNameLabel.text = nil
        backImage.image = nil
        
    }
    
    private func setUpViews(){
        favoriteButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        favoriteButton.backgroundColor = .clear
        favoriteButton.setBackgroundImage(UIImage(named: "bookmark-light"), for: .normal)
    }
    
    private func setViews(){
        contentView.addSubview(backImage)
        [
            categoryLabel,
            articleNameLabel,
            favoriteButton,
        ].forEach { backImage.addSubview($0) }
    }
    
    private func applyGradient(){
        backImage.bounds = self.contentView.bounds
        backImage.applyGradientMask(colors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)], locations: [0.2, 1.0])
    }
    
    private func layoutViews(){
        backImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        articleNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backImage.snp.bottom).offset(16)
            make.leading.equalTo(backImage.snp.leading).offset(16)
            make.trailing.equalTo(backImage.snp.trailing).offset(16)
            make.height.equalTo(48)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.bottom.equalTo(articleNameLabel.snp.top).offset(8)
            make.leading.equalTo(backImage.snp.leading).offset(16)
            make.height.equalTo(18)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(backImage.snp.top).offset(16)
            make.trailing.equalTo(backImage.snp.trailing).offset(16)
            make.width.height.equalTo(24)        }
        
    }
}

//MARK: - Configure Cell UI Public Method
extension ArticleCouruselCell{
    func configCell(categoryLabelText: String, articleNameText: String, image: UIImage?){
        categoryLabel.text = categoryLabelText
        articleNameLabel.text = articleNameText
        if let image = image{
            backImage.image = image
            applyGradient()
        } else{
            //добавить spineer
        }
        
    }
}
