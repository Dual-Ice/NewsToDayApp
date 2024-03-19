//
//  RecomendedCell.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//

import UIKit
import SnapKit

class RecomendedCell: UICollectionViewCell {
    static let resuseID = "RecomendedCell"
    
    private let categoryLabel = LabelsFactory.makeCategoryLabel()
    private let articleNameLabel = LabelsFactory.makeArticleHeaderLabel()
    private let backImage = ImageViewFactory.makeCornerRadiusImage()
    
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
        categoryLabel.font = UIFont.TextFont.Main.recommendedArticleCategory
        articleNameLabel.textColor = UIColor(named: ConstColors.blackPrimary)
        articleNameLabel.font = UIFont.TextFont.Main.recommendedArticleLabel
    }
    
    private func setViews(){
        [
            backImage,
            categoryLabel,
            articleNameLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
    private func applyGradient(){
        backImage.bounds = self.contentView.bounds
        backImage.applyGradientMask(colors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)], locations: [0.2, 1.0])
    }
    
    private func layoutViews(){
        backImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.top.equalTo(contentView.snp.top)
            make.height.width.equalTo(96)
        }
        categoryLabel.snp.makeConstraints { make in
            make.bottom.equalTo(articleNameLabel.snp.top).offset(-8)
            make.leading.equalTo(backImage.snp.trailing).offset(8)
            make.height.equalTo(20)
        }
        
        articleNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.leading.equalTo(backImage.snp.trailing).offset(8)
            make.trailing.equalTo(contentView.snp.trailing).offset(-8)
            make.height.equalTo(48)
        }
    }
}

//MARK: - Configure Cell UI Public Method
extension RecomendedCell{
    func configCell(categoryLabelText: String, articleNameText: String, image: UIImage?){
        categoryLabel.text = categoryLabelText
        articleNameLabel.text = articleNameText
        if let image = image{
            backImage.image = image
            //applyGradient()
        } else{
            backImage.backgroundColor = .blue
            //добавить spineer
        }
        
    }
}
