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
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .white
        spinner.style = .medium
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
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
        categoryLabel.textColor = UIColor(named: ConstColors.greyPrimary)
        articleNameLabel.textColor = UIColor(named: ConstColors.blackPrimary)
        articleNameLabel.font = UIFont.TextFont.Main.recommendedArticleLabel
    }
    
    private func setUpSpiner(){
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerY.equalTo(backImage.snp.centerY)
            make.centerX.equalTo(backImage.snp.centerX)
        }
        spinner.startAnimating()
    }
    
    private func setViews(){
        [
            backImage,
            categoryLabel,
            articleNameLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
    private func layoutViews(){
        backImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.top.equalTo(contentView.snp.top)
            make.height.width.equalTo(96)
        }
        categoryLabel.snp.makeConstraints { make in
            make.bottom.equalTo(articleNameLabel.snp.top).offset(-8)
            make.leading.equalTo(backImage.snp.trailing).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-8)
        }
        
        articleNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.leading.equalTo(backImage.snp.trailing).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-8)
        }
    }
}

//MARK: - Configure Cell UI Public Method
extension RecomendedCell{
    func configCell(categoryLabelText: String?, articleNameText: String?, image: UIImage?){
        categoryLabel.text = categoryLabelText
        articleNameLabel.text = articleNameText
        if let image = image{
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            backImage.image = image
        } else{
            setUpSpiner() //добавить spineer
            backImage.backgroundColor = .lightGray
        }
    }
}
