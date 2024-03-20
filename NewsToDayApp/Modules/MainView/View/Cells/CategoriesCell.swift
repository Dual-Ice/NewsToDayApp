//
//  CategoriesCell.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//

import UIKit
import SnapKit

class CategoriesCell: UICollectionViewCell {
    static let resuseID = "CategoriesCell"
    
    private let categoryLabel = LabelsFactory.makeCategoryTagLabel()
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
    }
    
    private func setUpViews(){
        backImage.layer.cornerRadius = 16
        backImage.backgroundColor = UIColor(named: ConstColors.greyLighter)
        categoryLabel.textColor = UIColor(named: ConstColors.greyPrimary)
    }
    
    private func setViews(){
        contentView.addSubview(backImage)
        backImage.addSubview(categoryLabel)
    }
    
    private func layoutViews(){
        backImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        categoryLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backImage.snp.centerX)
            make.centerY.equalTo(backImage.snp.centerY)
        }
    }
}

//MARK: - Configure Cell UI Public Method
extension CategoriesCell{
    func configCell(categoryLabelText: String?){
        categoryLabel.text = categoryLabelText
    }
}
