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
  
//    override var isSelected: Bool {
//        didSet {
//            if isSelected {
//                categoryLabel.textColor = UIColor(named: ConstColors.customWhite)
//                backImage.backgroundColor = UIColor(named: ConstColors.purplePrimary)
//                print("Sellected \(backImage.backgroundColor)")
//            } else {
//                categoryLabel.textColor = UIColor(named: ConstColors.greyPrimary)
//                backImage.backgroundColor = UIColor(named: ConstColors.greyLighter)
//            }
//        }
//    }

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
        contentView.addSubview(categoryLabel)
    }
    
    private func layoutViews(){
        backImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        categoryLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
}

//MARK: - Configure Cell UI Public Method
extension CategoriesCell{
    func configCell(categoryLabelText: String?){
        categoryLabel.text = categoryLabelText
    }
    
    func setSelectedColors(){
        categoryLabel.textColor = UIColor(named: ConstColors.customWhite)
        backImage.backgroundColor = UIColor(named: ConstColors.purplePrimary)
    }
    
    func setDefaultColors(){
        categoryLabel.textColor = UIColor(named: ConstColors.greyPrimary)
        backImage.backgroundColor = UIColor(named: ConstColors.greyLighter)
    }
}
